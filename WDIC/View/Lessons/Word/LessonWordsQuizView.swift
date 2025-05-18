//
//  LessonWordsQuizView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonWordsQuizView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: LessonViewModel

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center) {
                QuizWordContentView().environmentObject(viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
                    .padding(.top, 5)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "단어"))
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct QuizWordContentView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @StateObject var quizViewModel = VocaQuizViewModel()

    private var totalCards: Int {
        quizViewModel.quiz?.quizzes.count ?? 0
    }
    private var progress: CGFloat {
        totalCards > 0 ? CGFloat(currentIndex + 1) / CGFloat(totalCards) : 0
    }
    
    @State private var showModal = false
    @State private var currentIndex: Int = 0
    @State private var showCompleteView = false
    
    private var currentQuiz: VocabularyQuiz.VocaQuiz? {
        guard let quizzes = quizViewModel.quiz?.quizzes, currentIndex < quizzes.count else { return nil }
        return quizzes[currentIndex]
    }

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                titleView
                groupProgressView
                quizTextView
                QuizWordsView(currentQuiz: currentQuiz).environmentObject(quizViewModel)
                buttonView
            }
            .onAppear {
                // 백엔드 대신 Mock 데이터 사용
                quizViewModel.setupMockData()
                // 원래 코드 - 필요할 때 주석 해제
                // quizViewModel.fetchQuizzes(forLesson: viewModel.lessonId)
            }
            if showModal {
                ModalAnswerView(showModal: $showModal, currentIndex: $currentIndex, showCompleteView: $showCompleteView)
                    .environmentObject(viewModel)
                    .environmentObject(quizViewModel)
            }
            NavigationLink(destination: CompleteWordView().environmentObject(viewModel), isActive: $showCompleteView) {
                EmptyView()
            }
        }
        .animation(.default, value: showModal)
        .edgesIgnoringSafeArea(.all)
    }
    
    // 기존 코드 유지...
    private var titleView: some View {
        VStack {
            Text("단어 익히기 QUIZ")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.dark)
        }
    }
    private var groupProgressView: some View {
        VStack {
            Group {
                ProgressText(currentIndex: currentIndex, totalCards: totalCards)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
                ProgressBar(progress: .constant(progress))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
            }
        }
    }
    private var quizTextView: some View {
        VStack {
            if let currentQuiz = currentQuiz {
                Text(currentQuiz.question)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.darkColor)
            }
        }
    }
    private var buttonView: some View {
        Button(action: {
            if let currentQuiz = currentQuiz {
                quizViewModel.checkAnswer(forQuiz: currentQuiz)
                showModal = true
            }
        }) {
            Text("선택하기")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                .background(Color.Color6)
                .cornerRadius(10)
                .padding(.horizontal, 40)
        }
    }
}

struct QuizWordsView: View {
    @EnvironmentObject var quizViewModel: VocaQuizViewModel
    var currentQuiz: VocabularyQuiz.VocaQuiz?

    let colors: [Color] = [Color.Color14, Color.Color15, Color.Color10, Color.Color11]

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(0..<2, id: \.self) { row in
                HStack(spacing: 20) {
                    ForEach(0..<2, id: \.self) { column in
                        if let option = currentQuiz?.options[safe: row * 2 + column] {
                            optionCard(option: option, color: colors[row * 2 + column])
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 30)
    }
    func optionCard(option: String, color: Color) -> some View {
        Text(option)
            .font(.headline)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.22))
            .frame(width: 150, height: 170)
            .background(color)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(quizViewModel.selectedOption == option ? Color.Color6 : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                quizViewModel.selectedOption = option
            }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

