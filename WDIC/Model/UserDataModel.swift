//
//  UserDataModel.swift
//  WDIC
//
//  Created by 이융의 on 12/16/23.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String { _id }
    let _id: String
    let email: String
    let password: String?
    let name: String
    let profileImage: String
    let statusMessage: String
    let points: Int
    let level: Int
    let refreshToken: String?

    let google: SocialAccount?
    let apple: SocialAccount?
    let kakao: SocialAccount?

    let blockedUsers: [String]? // Assuming the ObjectId is represented as String
    let blockedQuestions: [String]? // Same assumption as above
    let reportCount: Int?
    let role: UserRole?

    enum UserRole: String, Codable {
        case user
        case admin
    }

    struct SocialAccount: Codable {
        var id: String
        var email: String
    }
    let createdAt: String
    let updatedAt: String
    
    var createdAtDate: String {
        return String(createdAt.prefix(10))
    }
    var updatedAtDate: String {
        return String(updatedAt.prefix(10))
    }
}

struct LoginResponse: Codable {
    let user: User
    let JWTAccessToken: String
    let JWTRefreshToken: String
}
