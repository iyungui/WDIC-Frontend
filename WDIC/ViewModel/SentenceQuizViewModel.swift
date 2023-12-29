//
//  SentenceQuizViewModel.swift
//  WDIC
//
//  Created by 이융의 on 12/20/23.
//

import Foundation
import Combine

class SentenceQuizViewModel: ObservableObject {
    @Published var quiz: SentenceQuiz? // 단일 객체로 변경
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedOption: String?
    typealias Quiz = SentenceQuiz.SentQuiz

    
    // 정답 확인 결과와 관련된 정보를 제공하기 위한 구조체
    struct AnswerFeedback {
        let fullSentence: String
        let pinyin: String
        let translation: String
        let message: String
    }

    @Published var answerFeedback: AnswerFeedback?
    
    private let quizService: QuizService
    private var cancellables = Set<AnyCancellable>()

    init(quizService: QuizService = QuizService()) {
        self.quizService = quizService
    }

    func fetchQuizzes(forLesson lessonId: String) {
        print("Fetching quizzes for lesson ID: \(lessonId)")
        isLoading = true
        errorMessage = nil

        quizService.getSentenceQuiz(lessonId: lessonId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedQuiz):
                    self?.quiz = fetchedQuiz
                case .failure(let error):
                    print("Error fetching quizzes: \(error.localizedDescription)")
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // 정답 확인 함수
    func checkAnswer(forQuiz quiz: Quiz) {
        guard let selectedOption = selectedOption else {
            print("No option selected")
            return
        }

        print("Selected Option: \(selectedOption) for Quiz: \(quiz.fullSentence)")

        let feedbackMessage = selectedOption == quiz.correctAnswer ? "정답입니다!" : "오답입니다!"
        print(feedbackMessage)

        answerFeedback = AnswerFeedback(
            fullSentence: quiz.fullSentence,
            pinyin: quiz.pinyin,
            translation: quiz.translation,
            message: feedbackMessage
        )
    }

}
