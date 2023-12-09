//
//  WordDataModel.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import Foundation

// 단어 데이터 모델
struct Word: Equatable {
    var hanja: String
    var meaning: String
    var pinyin: String
    var audio: [String]

    static func ==(lhs: Word, rhs: Word) -> Bool {
        return lhs.hanja == rhs.hanja && lhs.meaning == rhs.meaning
    }
}


// 단어 데이터 인스턴스 생성
let sampleWords = [
    Word(hanja: "电话", meaning: "전화", pinyin: "diànhuà", audio: []),
    Word(hanja: "年龄", meaning: "연령", pinyin: "niánlíng", audio: []),
    Word(hanja: "国籍", meaning: "국적", pinyin: "guójí", audio: []),
    Word(hanja: "职业", meaning: "직업", pinyin: "zhíyè", audio: []),
    Word(hanja: "性别", meaning: "성별", pinyin: "xìngbié", audio: []),
    Word(hanja: "住址", meaning: "주소", pinyin: "zhùzhǐ", audio: []),
    Word(hanja: "姓名", meaning: "이름", pinyin: "xìngmíng", audio: []),
    Word(hanja: "学校", meaning: "학교", pinyin: "xuéxiào", audio: []),
    Word(hanja: "岁", meaning: "세, 살", pinyin: "suì", audio: []),
    Word(hanja: "中国", meaning: "중국", pinyin: "zhōngguó", audio: []),
    Word(hanja: "美国", meaning: "미국", pinyin: "měiguó", audio: []),
    Word(hanja: "韩国", meaning: "한국", pinyin: "hánguó", audio: []),
    Word(hanja: "男", meaning: "남성", pinyin: "nán", audio: []),
    Word(hanja: "女", meaning: "여성", pinyin: "nǚ", audio: []),
    Word(hanja: "楼", meaning: "층,층집", pinyin: "lóu", audio: [])
    
]

enum QuizType {
    case meaningToHanja, hanjaToMeaning
}
