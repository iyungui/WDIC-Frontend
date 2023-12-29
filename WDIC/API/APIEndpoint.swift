//
//  APIEndpoint.swift
//  WDIC
//
//  Created by 이융의 on 12/18/23.
//

import Foundation

struct APIEndpoint {
    static private let baseURL = "https://wdic.net/"

    // MARK: - USER
    static let signInWithAppleURL = baseURL + "auth/apple/callback"
    
    static let registerUserURL = baseURL + "api/users/email/signup"
    static let sendVerifyCodeForRegisterURL = baseURL + "api/users/email/signup/sendCode"
    static let verifyEmailCodeURL = baseURL + "api/users/email/signup/verifyCode"
    
    static let loginUserURL = baseURL + "api/users/email/login"
    static let renewAccessTokenURL = baseURL + "api/users/renewToken"
    static let validateTokenURL = baseURL + "api/users/validateToken"
    static let logoutUserURL = baseURL + "api/users/logout"
    
    static let getProfileURL = baseURL + "api/users/profile"    // + /userId
    
    static let requestResetPWURL = baseURL + "api/users/requestResetPassword"
    static let verifyCodeURL = baseURL + "api/users/verifyCode"
    static let resetPWURL = baseURL + "api/users/resetPassword"
    static let updateUserURL = baseURL + "api/users/update"
    
    static let deleteUserURL = baseURL + "api/users/deleteUser"
    
    // MARK: - CHAPTER
    static let getChaptersURL = baseURL + "api/chapters"
    static let getLessonListURL = baseURL + "api/chapters"
    
    // MARK: - LESSON
    static let getLessonPartURL = baseURL + "api/lessons/lessons"   // + /:lessonId/:partType
    
    // MARK: - QUIZ
    static let quizURL = baseURL + "api/quiz"    // + /658136dcd427e93960e61c00/sentence-quiz
}
