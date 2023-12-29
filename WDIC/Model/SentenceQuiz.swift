//
//  SentenceQuiz.swift
//  WDIC
//
//  Created by 이융의 on 12/20/23.
//

import Foundation

struct SentenceQuiz: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let lessonId: String
    let quizzes: [SentQuiz]
    
    struct SentQuiz: Codable {
        let fullSentence: String
        let quizSentence: String
        let options: [String]
        let correctAnswer: String
        let answerIndex: Int
        let pinyin: String
        let translation: String
    }
    
    let createdAt: String
    let updatedAt: String
}
