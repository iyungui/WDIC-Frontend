//
//  UserAuthenticationManager.swift
//  WDIC
//
//  Created by 이융의 on 12/18/23.
//

import Foundation
import Alamofire

class UserAuthenticationManager: ObservableObject {
    @Published var isUserAuthenticated: Bool = KeyChain.read(key: "JWTAccessToken") != nil {
        didSet {
            print("UserAuthenticationManager: isUserAuthenticated updated to \(isUserAuthenticated)")
        }
    }
    @Published var isOnboardingComplete: Bool = false {
        didSet {
            print("UserAuthenticationManager: isOnboardingComplete updated to \(isOnboardingComplete)")
        }
    }
    @Published var showingLoginView: Bool = false {
        didSet {
            print("UserAuthenticationManager: showingLoginView updated to \(showingLoginView)")
        }
    }
    
    // MARK: - LogIn
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let url = APIEndpoint.loginUserURL
        let parameters = [
            "email": email,
            "password": password
        ]

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                KeyChain.create(key: "JWTAccessToken", token: loginResponse.JWTAccessToken)
                KeyChain.create(key: "JWTRefreshToken", token: loginResponse.JWTRefreshToken)
                DispatchQueue.main.async {
                    self.isUserAuthenticated = true
                }
                completion(.success(loginResponse))
            case .failure:
                if let data = response.data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    // Use a custom ErrorResponse struct to handle the error
                    let errorMessage = errorResponse.message
                    completion(.failure(NSError(domain: "", code: response.response?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                } else {
                    completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
                }
            }
        }
    }

    struct ErrorResponse: Codable {
        let message: String
    }

    
    // MARK: - Logout
    
    func logout(completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = APIEndpoint.logoutUserURL

        guard let token = KeyChain.read(key: "JWTAccessToken") else {
            completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request(url, method: .post, headers: headers).response { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    KeyChain.delete(key: "JWTAccessToken")
                    KeyChain.delete(key: "JWTRefreshToken")
                    self.isUserAuthenticated = false
                    print("UserAuthenticationManager: logout called, tokens deleted")
                    completion(.success(true))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    
//    func revokeUser(completion: @escaping (Result<Bool, Error>) -> Void) {
//        let url = APIEndpoint.revokeTokenURL
//        
//        guard let token = KeyChain.read(key: "JWTAccessToken") else {
//            completion(.failure(NSError(domain: "UserService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
//            return
//        }
//        
//        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
//
//        AF.request(url, method: .post, headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let json = value as? [String: Any], let success = json["success"] as? Bool, success {
//                    if KeyChain.read(key: "JWTAccessToken") != nil {
//                        KeyChain.delete(key: "JWTAccessToken")
//                        KeyChain.delete(key: "JWTRefreshToken")
//                        self.isUserAuthenticated = false
//                    }
//                    
//                    completion(.success(true))
//                } else {
//                    let error = NSError(domain: "RevokeError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to revoke user data and token"])
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    // MARK: - Renew AccessToken <AUTO LOGIN>
    
    func validateToken() {
        let accessToken = KeyChain.read(key: "JWTAccessToken")
        let refreshToken = KeyChain.read(key: "JWTRefreshToken")
        
        guard let accessToken = accessToken, let refreshToken = refreshToken else {
            isUserAuthenticated = false
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "x-refresh-token": refreshToken
        ]
        
        let url = APIEndpoint.validateTokenURL
        
        AF.request(url, method: .post, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let valid = json["valid"] as? Bool {
                    if valid {
                        self.isUserAuthenticated = true
                    } else if let newAccessToken = json["newAccessToken"] as? String,
                              let newRefreshToken = json["newRefreshToken"] as? String {
                        KeyChain.create(key: "JWTAccessToken", token: newAccessToken)
                        KeyChain.create(key: "JWTRefreshToken", token: newRefreshToken)
                        print("validateToken success")
                        self.isUserAuthenticated = true
                    } else {
                        print("validateToken fail showing Login")
                        self.isUserAuthenticated = false
                        self.showingLoginView = true
                    }
                }
            case .failure:
                print("validateToken fail showing Login 2")
                self.isUserAuthenticated = false
                self.showingLoginView = true
            }
        }
    }
    
    // retry
    func renewAccessToken(completion: @escaping (Bool) -> Void) {
        guard let token = KeyChain.read(key: "JWTRefreshToken") else {
            self.handleTokenExpiry()
            completion(false)
            return
        }
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        let renewTokenURL = APIEndpoint.renewAccessTokenURL

        AF.request(renewTokenURL, method: .post, headers: headers)
            .responseDecodable(of: AccessTokenResponse.self) { response in
                switch response.result {
                case .success(let tokenResponse):
                    KeyChain.create(key: "JWTAccessToken", token: tokenResponse.accessToken)
                    completion(true)
                case .failure:
                    print("리프레시 토큰 만료, 로그인 필요")
                    self.handleTokenExpiry()
                    completion(false)
                }
            }
    }
    
    private func handleTokenExpiry() {
        DispatchQueue.main.async {
            KeyChain.delete(key: "JWTAccessToken")
            KeyChain.delete(key: "JWTRefreshToken")
            self.isUserAuthenticated = false
            self.showingLoginView = true
        }
    }

    struct AccessTokenResponse: Codable {
        let accessToken: String
    }
    // MARK: - Delete User
    
}
