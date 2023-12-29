//
//  SignUpViewModel.swift
//  WDIC
//
//  Created by 이융의 on 12/18/23.
//

import Foundation

class SignUpViewModel: ObservableObject {
    let userService = UserService()

    @Published var isEmailVerified = false
    @Published var errorMessage: String?

    @Published var isLoading = false

    func sendVerificationCode(email: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        userService.sendVerificationCodeForRegister(email: email) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    func verifyEmailCode(email: String, verifyCode: String, completion: @escaping (Bool) -> Void) {
        isLoading = true

        userService.verifyEmailCode(email: email, code: verifyCode) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success:
                    self?.isEmailVerified = true
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }

    func registerUser(email: String, password: String, name: String, completion: @escaping (Bool) -> Void) {
        isLoading = true

        userService.registerUser(email: email, password: password, name: name, role: "user") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}
