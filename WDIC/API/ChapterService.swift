//
//  ChapterService.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation
import Alamofire
import SwiftUI

class ChapterService {

    func getChapters(completion: @escaping (Result<[Chapter], Error>) -> Void) {
        let url = APIEndpoint.getChaptersURL
        
        guard let token = KeyChain.read(key: "JWTAccessToken") else {
            print("No Authorization Token Found for Bookstories")
            completion(.failure(NSError(domain: "ChapterService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [Chapter].self) { response in
            switch response.result {
            case .success(let chapters):
                completion(.success(chapters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
