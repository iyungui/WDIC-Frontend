//
//  VocaQuizViewModel.swift
//  WDIC
//
//  Created by 이융의 on 12/27/23.
//

import Foundation
import Combine

class VocaQuizViewModel: ObservableObject {
    @Published var quiz: VocabularyQuiz?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedOption: String?
    typealias Quiz = VocabularyQuiz.VocaQuiz
    
    // 정답 확인 결과와 관련된 정보를 제공하기 위한 구조체
    struct AnswerFeedback {
        let word: String
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

        quizService.getVocaQuiz(lessonId: lessonId) { [weak self] result in
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
    func checkAnswer(forQuiz quiz: VocabularyQuiz.VocaQuiz?) {
        guard let quiz = quiz, let selectedOption = selectedOption else { return }

        print("Selected Option: \(selectedOption) for Quiz: \(quiz.question)")

        let feedbackMessage = selectedOption == quiz.correctAnswer ? "정답입니다!" : "오답입니다!"
        print(feedbackMessage)

        answerFeedback = AnswerFeedback(
            word: quiz.correctAnswer,
            pinyin: quiz.pinyin,
            translation: quiz.translation,
            message: feedbackMessage
        )
    }
}
