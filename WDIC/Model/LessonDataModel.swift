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


// MARK: - Mock Data Extensions
extension Vocabulary {
    static let mockItems: [Vocabulary] = [
        Vocabulary(word: "你好", meaning: "안녕하세요", pinyin: "nǐ hǎo"),
        Vocabulary(word: "谢谢", meaning: "감사합니다", pinyin: "xiè xiè"),
        Vocabulary(word: "再见", meaning: "안녕히 가세요", pinyin: "zài jiàn"),
        Vocabulary(word: "朋友", meaning: "친구", pinyin: "péng yǒu"),
        Vocabulary(word: "学习", meaning: "공부하다", pinyin: "xué xí"),
        Vocabulary(word: "老师", meaning: "선생님", pinyin: "lǎo shī"),
        Vocabulary(word: "学生", meaning: "학생", pinyin: "xué shēng"),
        Vocabulary(word: "中国", meaning: "중국", pinyin: "zhōng guó"),
        Vocabulary(word: "韩国", meaning: "한국", pinyin: "hán guó"),
        Vocabulary(word: "家人", meaning: "가족", pinyin: "jiā rén")
    ]
}

extension Sentence {
    static let mockItems: [Sentence] = [
        Sentence(_id: "1", fullSentence: "我是韩国人", parts: ["我", "是", "韩国", "人"], blankIndices: [2], pinyin: "wǒ shì hán guó rén", translation: "저는 한국 사람입니다"),
        Sentence(_id: "2", fullSentence: "他是我的朋友", parts: ["他", "是", "我的", "朋友"], blankIndices: [3], pinyin: "tā shì wǒ de péng yǒu", translation: "그는 내 친구입니다"),
        Sentence(_id: "3", fullSentence: "我在学习中文", parts: ["我", "在", "学习", "中文"], blankIndices: [2, 3], pinyin: "wǒ zài xué xí zhōng wén", translation: "저는 중국어를 공부하고 있습니다"),
        Sentence(_id: "4", fullSentence: "他们是大学生", parts: ["他们", "是", "大学生"], blankIndices: [0], pinyin: "tā men shì dà xué shēng", translation: "그들은 대학생입니다"),
        Sentence(_id: "5", fullSentence: "这是我的家人", parts: ["这", "是", "我的", "家人"], blankIndices: [3], pinyin: "zhè shì wǒ de jiā rén", translation: "이는 내 가족입니다")
    ]
}

extension Pronunciation {
    static let mockItems: [Pronunciation] = [
        Pronunciation(sentence: "你好，我叫小明", pinyin: "nǐ hǎo, wǒ jiào xiǎo míng", translation: "안녕하세요, 저는 샤오밍입니다"),
        Pronunciation(sentence: "很高兴认识你", pinyin: "hěn gāo xìng rèn shí nǐ", translation: "만나서 반갑습니다"),
        Pronunciation(sentence: "我是韩国人", pinyin: "wǒ shì hán guó rén", translation: "저는 한국 사람입니다"),
        Pronunciation(sentence: "我在大学学习中文", pinyin: "wǒ zài dà xué xué xí zhōng wén", translation: "저는 대학에서 중국어를 공부합니다"),
        Pronunciation(sentence: "我的爱好是听音乐", pinyin: "wǒ de ài hào shì tīng yīn yuè", translation: "제 취미는 음악 듣기입니다")
    ]
}

extension Writing {
    static let mockItems: [Writing] = [
        Writing(exampleSentence: "大家好，我叫李明。我是韩国人，今年20岁。我在首尔大学学习中文。我的爱好是听音乐和看电影。很高兴认识大家。", taskDescription: "자기소개를 중국어로 작성해보세요."),
        Writing(exampleSentence: "我的家人有四口人：爸爸、妈妈、妹妹和我。爸爸是一名医生，妈妈是一名老师。妹妹今年15岁，是一名高中生。", taskDescription: "가족에 대해 중국어로 작성해보세요."),
        Writing(exampleSentence: "我的朋友叫张小华。他今年21岁，是一名大学生。他学习计算机科学。他的爱好是打篮球和游泳。我们经常一起吃饭，一起学习。", taskDescription: "친구에 대해 중국어로 작성해보세요.")
    ]
}

extension Chapter {
    static let mockItems: [Chapter] = [
        Chapter(_id: "1", title: "自我介绍", description: "나를 소개하기", number: 1, lessons: ["lesson1", "lesson2", "lesson3"], createdAt: "2023-12-01", updatedAt: "2023-12-01"),
        Chapter(_id: "2", title: "家人介绍", description: "가족 소개하기", number: 2, lessons: ["lesson4", "lesson5"], createdAt: "2023-12-02", updatedAt: "2023-12-02"),
        Chapter(_id: "3", title: "朋友介绍", description: "친구 소개하기", number: 3, lessons: ["lesson6", "lesson7", "lesson8"], createdAt: "2023-12-03", updatedAt: "2023-12-03"),
        Chapter(_id: "4", title: "学校生活", description: "학교 생활", number: 4, lessons: ["lesson9"], createdAt: "2023-12-04", updatedAt: "2023-12-04"),
        Chapter(_id: "5", title: "爱好", description: "취미 활동", number: 5, lessons: ["lesson10", "lesson11"], createdAt: "2023-12-05", updatedAt: "2023-12-05")
    ]
}

extension VocabularyQuiz.VocaQuiz {
    static let mockItems: [VocabularyQuiz.VocaQuiz] = [
        VocabularyQuiz.VocaQuiz(type: "word", question: "안녕하세요", options: ["你好", "谢谢", "再见", "朋友"], correctAnswer: "你好", answerIndex: 0, pinyin: "nǐ hǎo", translation: "안녕하세요"),
        VocabularyQuiz.VocaQuiz(type: "word", question: "감사합니다", options: ["你好", "谢谢", "再见", "朋友"], correctAnswer: "谢谢", answerIndex: 1, pinyin: "xiè xiè", translation: "감사합니다"),
        VocabularyQuiz.VocaQuiz(type: "word", question: "안녕히 가세요", options: ["你好", "谢谢", "再见", "朋友"], correctAnswer: "再见", answerIndex: 2, pinyin: "zài jiàn", translation: "안녕히 가세요"),
        VocabularyQuiz.VocaQuiz(type: "word", question: "친구", options: ["你好", "谢谢", "再见", "朋友"], correctAnswer: "朋友", answerIndex: 3, pinyin: "péng yǒu", translation: "친구"),
        VocabularyQuiz.VocaQuiz(type: "word", question: "공부하다", options: ["学习", "老师", "学生", "中国"], correctAnswer: "学习", answerIndex: 0, pinyin: "xué xí", translation: "공부하다")
    ]
}

extension VocabularyQuiz {
    static let mockItem = VocabularyQuiz(_id: "vq1", lessonId: "lesson1", quizzes: VocabularyQuiz.VocaQuiz.mockItems, createdAt: "2023-12-01", updatedAt: "2023-12-01")
}

extension SentenceQuiz.SentQuiz {
    static let mockItems: [SentenceQuiz.SentQuiz] = [
        SentenceQuiz.SentQuiz(fullSentence: "我是韩国人", quizSentence: "我是____人", options: ["中国", "日本", "韩国", "美国"], correctAnswer: "韩国", answerIndex: 2, pinyin: "wǒ shì hán guó rén", translation: "저는 한국 사람입니다"),
        SentenceQuiz.SentQuiz(fullSentence: "他是我的朋友", quizSentence: "他是我的____", options: ["老师", "朋友", "学生", "家人"], correctAnswer: "朋友", answerIndex: 1, pinyin: "tā shì wǒ de péng yǒu", translation: "그는 내 친구입니다"),
        SentenceQuiz.SentQuiz(fullSentence: "我在学习中文", quizSentence: "我在学习____", options: ["英文", "中文", "韩文", "日文"], correctAnswer: "中文", answerIndex: 1, pinyin: "wǒ zài xué xí zhōng wén", translation: "저는 중국어를 공부하고 있습니다"),
        SentenceQuiz.SentQuiz(fullSentence: "他们是大学生", quizSentence: "____是大学生", options: ["我", "你", "他", "他们"], correctAnswer: "他们", answerIndex: 3, pinyin: "tā men shì dà xué shēng", translation: "그들은 대학생입니다"),
        SentenceQuiz.SentQuiz(fullSentence: "这是我的家人", quizSentence: "这是我的____", options: ["朋友", "老师", "家人", "学生"], correctAnswer: "家人", answerIndex: 2, pinyin: "zhè shì wǒ de jiā rén", translation: "이는 내 가족입니다")
    ]
}

extension SentenceQuiz {
    static let mockItem = SentenceQuiz(_id: "sq1", lessonId: "lesson1", quizzes: SentenceQuiz.SentQuiz.mockItems, createdAt: "2023-12-01", updatedAt: "2023-12-01")
}

// LessonViewModel에 Mock 데이터를 사용할 준비 메서드 추가
extension LessonViewModel {
    func setupMockData() {
        self.vocabulary = Vocabulary.mockItems
        self.sentences = Sentence.mockItems
        self.pronunciation = Pronunciation.mockItems
        self.writing = Writing.mockItems
    }
}

// 퀴즈 뷰모델에 Mock 데이터 사용 준비 메서드 추가
extension VocaQuizViewModel {
    func setupMockData() {
        self.quiz = VocabularyQuiz.mockItem
    }
}

extension SentenceQuizViewModel {
    func setupMockData() {
        self.quiz = SentenceQuiz.mockItem
    }
}

// ChapterViewModel에 Mock 데이터 사용 준비 메서드 추가
extension ChapterViewModel {
    func setupMockData() {
        self.chapters = Chapter.mockItems
    }
}
