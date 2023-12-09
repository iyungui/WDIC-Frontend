//
//  SentenceDataModel.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import Foundation

struct Sentence: Identifiable {
    let id = UUID()
    var content: String
    var meaning: String
    var pinyin: String
    var audio: String
}

let sampleSentences = [
    Sentence(content: "他叫什么名字？", meaning: "그의 이름이 뭐예요?", pinyin: "Tā jiào shénme míngzi?", audio: ""),
    Sentence(content: "他今年多大？", meaning: "그는 올해 몇 살이에요?", pinyin: "Tā jīnnián duō dà?", audio: ""),
    Sentence(content: "他是哪国人？", meaning: "그는 어느 나라 사람이에요?", pinyin: "Tā shì nǎ guó rén?", audio: ""),
    Sentence(content: "她做什么工作？", meaning: "그녀는 어떤 일을 해요?", pinyin: "Tā zuò shénme gōngzuò?", audio: ""),
    Sentence(content: "她是男的，还是女的？", meaning: "그녀는 남자인가요, 여자인가요?", pinyin: "Tā shì nán de, háishì nǚ de?", audio: ""),
    Sentence(content: "你在哪儿工作?", meaning: "당신은 어디서 일해요?", pinyin: "Nǐ zài nǎr gōngzuò?", audio: ""),
    Sentence(content: "我在首尔工作。", meaning: "저는 서울에서 일해요.", pinyin: "Wǒ zài Shǒu'ěr gōngzuò.", audio: ""),
    Sentence(content: "他在商店工作。", meaning: "그는 상점에서 일해요.", pinyin: "Tā zài shāngdiàn gōngzuò.", audio: ""),
    Sentence(content: "她在上海大学学习汉语。", meaning: "그녀는 상하이 대학에서 중국어를 공부해요.", pinyin: "Tā zài Shànghǎi Dàxué xuéxí Hànyǔ.", audio: ""),
    Sentence(content: "我在韩国外国语大学学习韩语。", meaning: "저는 한국외국어대학에서 한국어를 공부해요.", pinyin: "Wǒ zài Hánguó Wàiguóyǔ Dàxué xuéxí Hányǔ.", audio: "")
]


enum SentenceQuizType {
    case blank, configuration
}



/*
 문장 퀴즈: 주요문법: 9개의 문장,
 
 
 
 문장 배우기: 제시어에 따라 문장 데이터를 나누고,
 문장 데이터 하나마다 단어로 나누고, 단어가 많으면 해석 문제로 가야한다.
 
 작문 퀴즈할 때, 틀린 문장은 빨간색으로, 맞는 문장은 초록색 등으로 표시
 */
