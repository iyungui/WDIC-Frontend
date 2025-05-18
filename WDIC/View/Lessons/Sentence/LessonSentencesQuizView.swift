//
//  LessonSentencesQuizView.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

struct LessonSentencesQuizView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            VStack(alignment: .center) {
                QuizSentenceContentView()
                    .environmentObject(viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
                    .padding(.top, 5)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "문장"))
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct QuizSentenceContentView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @StateObject var quizViewModel = SentenceQuizViewModel()

    private var totalCards: Int {
        quizViewModel.quiz?.quizzes.count ?? 0
    }
    
    private var progress: CGFloat {
        totalCards > 0 ? CGFloat(currentIndex + 1) / CGFloat(totalCards) : 0
    }
    
    @State private var showModal = false
    @State private var currentIndex: Int = 0
    @State private var showCompleteView = false
    
    private var currentQuiz: SentenceQuiz.SentQuiz? {
        guard let quizzes = quizViewModel.quiz?.quizzes, currentIndex < quizzes.count else { return nil }
        return quizzes[currentIndex]
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                titleView
                groupProgressView
                quizContentView
                quizTextView
                quizOptionsView
            }
            .onAppear {
                // 백엔드 대신 Mock 데이터 사용
                quizViewModel.setupMockData()
                // 원래 코드 - 필요할 때 주석 해제
                // quizViewModel.fetchQuizzes(forLesson: viewModel.lessonId)
            }
            if showModal {
                SentenceModalAnswerView(showModal: $showModal, currentIndex: $currentIndex, showCompleteView: $showCompleteView)
                    .environmentObject(viewModel)
                    .environmentObject(quizViewModel)
            }
            NavigationLink(destination: CompleteSentenceView().environmentObject(viewModel), isActive: $showCompleteView) {
                EmptyView()
            }
        }
        .animation(.default, value: showModal)
        .edgesIgnoringSafeArea(.all)
    }
    
    // 기존 코드 유지...
    private var titleView: some View {
        VStack {
            Text("문장 배우기 QUIZ")
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
    private var quizContentView: some View {
        VStack(alignment: .center, spacing: 15) {
            Text(currentQuiz?.quizSentence ?? "")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(currentQuiz?.translation ?? "")
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.Color12)
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
    private var quizTextView: some View {
        VStack {
            Text("다음 빈칸 안에\n들어갈 말을 고르세요.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.darkColor)
        }
    }
    private var quizOptionsView: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(currentQuiz?.options ?? [], id: \.self) { option in
                Button(action: {
                    quizViewModel.selectedOption = option
                    if let currentQuiz = currentQuiz {
                        quizViewModel.checkAnswer(forQuiz: currentQuiz)
                        showModal = true
                    }
                }) {
                    Text(option)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.Color7, radius: 3, x: 0, y: 1)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}
#Preview {
    LessonSentencesQuizView()
}
