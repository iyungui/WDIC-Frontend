//
//  LessonService.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation
import Alamofire
import SwiftUI

class LessonService {
    
    func getLessonPart(lessonId: String, partType: String, completion: @escaping (Result<Any, Error>) -> Void) {
        let urlString = APIEndpoint.getLessonPartURL + "/\(lessonId)/\(partType)"

        guard let token = KeyChain.read(key: "JWTAccessToken") else {
            print("No Authorization Token Found")
            completion(.failure(NSError(domain: "LessonService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request(urlString, method: .get, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data else {
                    completion(.failure(NSError(domain: "LessonService", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    switch partType {
                    case "vocabulary":
                        let vocabData = try JSONDecoder().decode([Vocabulary].self, from: jsonData)
                        completion(.success(vocabData))
                    case "sentences":
                        let sentenceData = try JSONDecoder().decode([Sentence].self, from: jsonData)
                        completion(.success(sentenceData))
                    case "pronunciation":
                        let pronunciationData = try JSONDecoder().decode([Pronunciation].self, from: jsonData)
                        completion(.success(pronunciationData))
                    case "writing":
                        let writingData = try JSONDecoder().decode([Writing].self, from: jsonData)
                        completion(.success(writingData))
                    default:
                        completion(.failure(NSError(domain: "LessonService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unknown part type"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
