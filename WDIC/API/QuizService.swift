//
//  QuizService.swift
//  WDIC
//
//  Created by 이융의 on 12/20/23.
//

import Foundation
import Alamofire

class QuizService {
    // MARK: - 단어 퀴즈 가져오기
    
    func getVocaQuiz(lessonId: String, completion: @escaping (Result<VocabularyQuiz, Error>) -> Void) {
        let urlString = APIEndpoint.quizURL + "/\(lessonId)/vocabulary-quiz"
        
        guard let token = KeyChain.read(key: "JWTAccessToken") else {
            print("No Authorization Token Found for Quizzes")
            completion(.failure(NSError(domain: "QuizService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        AF.request(urlString, method: .get, headers: headers).validate().responseDecodable(of: VocabularyQuiz.self) { response in
            print("Response: \(response)")

            switch response.result {
            case .success(let quizzes):
                completion(.success(quizzes))
            case .failure(let error):
                print("Error in fetching quiz: \(error.localizedDescription)")
                if let httpStatusCode = response.response?.statusCode {
                    print("HTTP Status Code: \(httpStatusCode)")
                    switch httpStatusCode {
                    case 401:
                        completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "Unauthorized - Invalid Token"])))
                    case 404:
                        completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "Quiz not found for given lesson"])))
                    default:
                        completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "An HTTP error occurred"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "QuizService", code: -1, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
                }
            }
        }
    }
    
    // MARK: - 문장 퀴즈 가져오기
    
    func getSentenceQuiz(lessonId: String, completion: @escaping (Result<SentenceQuiz, Error>) -> Void) {
        let urlString = APIEndpoint.quizURL + "/\(lessonId)/sentence-quiz"

        guard let token = KeyChain.read(key: "JWTAccessToken") else {
            print("No Authorization Token Found for Quizzes")
            completion(.failure(NSError(domain: "QuizService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
            return
        }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        AF.request(urlString, method: .get, headers: headers).validate().responseDecodable(of: SentenceQuiz.self) { response in
            print("Response: \(response)")

            switch response.result {
            case .success(let quizzes):
                completion(.success(quizzes))
            case .failure(let error):
                print("Error in fetching quiz: \(error.localizedDescription)")
                if let httpStatusCode = response.response?.statusCode {
                    print("HTTP Status Code: \(httpStatusCode)")
                    switch httpStatusCode {
                    case 401:
                        completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "Unauthorized - Invalid Token"])))
                    case 404:
                        completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "Quiz not found for given lesson"])))
                    default:
                        completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "An HTTP error occurred"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "QuizService", code: -1, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
                }
            }
        }
    }
}


/*
 func getSentenceQuiz(lessonId: String, completion: @escaping (Result<SentenceQuiz, Error>) -> Void) {
     let urlString = APIEndpoint.sentenceQuizURL + "/\(lessonId)/sentence-quiz"
     print("Requesting quiz with URL: \(urlString)")

     guard let token = KeyChain.read(key: "JWTAccessToken") else {
         print("No Authorization Token Found for Quiz")
         completion(.failure(NSError(domain: "QuizService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No Authorization Token Found"])))
         return
     }

     let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

     AF.request(urlString, method: .get, headers: headers).validate().responseDecodable(of: SentenceQuiz.self) { response in
         print("Response: \(response)")

         switch response.result {
         case .success(let quiz):
             print("Successfully fetched quiz: \(quiz)")
             completion(.success(quiz))
         case .failure(let error):
             print("Error in fetching quiz: \(error.localizedDescription)")
             if let httpStatusCode = response.response?.statusCode {
                 print("HTTP Status Code: \(httpStatusCode)")
                 switch httpStatusCode {
                 case 401:
                     completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "Unauthorized - Invalid Token"])))
                 case 404:
                     completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "Quiz not found for given lesson"])))
                 default:
                     completion(.failure(NSError(domain: "QuizService", code: httpStatusCode, userInfo: [NSLocalizedDescriptionKey: "An HTTP error occurred"])))
                 }
             } else {
                 completion(.failure(NSError(domain: "QuizService", code: -1, userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])))
             }
         }
     }
 }
 */
