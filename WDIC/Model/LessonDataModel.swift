//
//  LessonDataModel.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation

struct Lesson: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let chapterId: String
    let level: Int
    let content: Content
    
    let createdAt: String
    let updatedAt: String

    var createdAtDate: String {
        String(createdAt.prefix(10))
    }

    var updatedAtDate: String {
        String(updatedAt.prefix(10))
    }
}

struct Content: Codable {
    let vocabulary: [Vocabulary]
    let sentences: [Sentence]
    let pronunciation: [Pronunciation]
    let writing: [Writing]
}

struct Vocabulary: Codable {
    let word: String
    let meaning: String
    let pinyin: String
}

struct Sentence: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let fullSentence: String
    let parts: [String]
    let blankIndices: [Int]
    let pinyin: String
    let translation: String
}

struct Pronunciation: Codable {
    let sentence: String
    let pinyin: String
    let translation: String
}

struct Writing: Codable {
    let exampleSentence: String
    let taskDescription: String
}
