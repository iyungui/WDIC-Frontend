//
//  VocabularyQuiz.swift
//  WDIC
//
//  Created by 이융의 on 12/27/23.
//

import Foundation

struct VocabularyQuiz: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let lessonId: String
    let quizzes: [VocaQuiz]
    
    struct VocaQuiz: Codable {
        let type: String
        let question: String
        let options: [String]
        let correctAnswer: String
        let answerIndex: Int
        let pinyin: String
        let translation: String
    }
    
    let createdAt: String
    let updatedAt: String
}
