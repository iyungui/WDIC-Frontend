//
//  ChapterDataModel.swift
//  WDIC
//
//  Created by 이융의 on 12/19/23.
//

import Foundation

struct Chapter: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let title: String
    let description: String
    let number: Int
    let lessons: [String]
    let createdAt: String
    let updatedAt: String

    var createdAtDate: String {
        return String(createdAt.prefix(10))
    }

    var updatedAtDate: String {
        return String(updatedAt.prefix(10))
    }
}
//
//struct ListLesson: Codable {
//    
//}
