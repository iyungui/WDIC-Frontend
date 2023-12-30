//
//  ModalAnswerView.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

struct ModalAnswerView: View {
    @Binding var showModal: Bool
    @EnvironmentObject var viewModel: LessonViewModel
    @EnvironmentObject var quizViewModel: VocaQuizViewModel
    @Binding var currentIndex: Int
    @Binding var showCompleteView: Bool
    
    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .center, spacing: 20) {
                titleView
                answerView
                nextButton
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .ignoresSafeArea()
//        .onTapGesture {
//            showModal = false
//        }
    }
    private var titleView: some View {
        HStack(spacing: 10) {
            Image(systemName: quizViewModel.answerFeedback?.message == "정답입니다!" ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title3)
                .foregroundColor(quizViewModel.answerFeedback?.message == "정답입니다!" ? .green : .red)
            Text(quizViewModel.answerFeedback?.message ?? "")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding([.top, .horizontal], 20)
    }
    private var answerView: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(quizViewModel.answerFeedback?.word ?? "")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Text(quizViewModel.answerFeedback?.pinyin ?? "")
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Text(quizViewModel.answerFeedback?.translation ?? "")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.black)
        .padding(.vertical, 10)
    }
    private var nextButton: some View {
        Button(action: {
            // 다음 퀴즈로 넘어가기
            if currentIndex < (quizViewModel.quiz?.quizzes.count ?? 0) - 1 {
                currentIndex += 1
                quizViewModel.selectedOption = nil
                showModal = false
            } else {
                showCompleteView = true
            }
        }) {
            Text("다음으로")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:  .infinity, maxHeight: 50)
                .background(quizViewModel.answerFeedback?.message == "정답입니다!" ? Color.Color1 : Color.Color0)
                .cornerRadius(10)
        }
        .padding([.horizontal, .bottom])
    }
}

struct SentenceModalAnswerView: View {
    @Binding var showModal: Bool
    @EnvironmentObject var viewModel: LessonViewModel
    @EnvironmentObject var quizViewModel: SentenceQuizViewModel
    @Binding var currentIndex: Int
    @Binding var showCompleteView: Bool

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .center, spacing: 20) {
                titleView
                answerView
                nextButton
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .ignoresSafeArea()
//        .onTapGesture {
//            showModal = false
//        }
    }

    private var titleView: some View {
        HStack(spacing: 10) {
            Image(systemName: quizViewModel.answerFeedback?.message == "정답입니다!" ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title3)
                .foregroundColor(quizViewModel.answerFeedback?.message == "정답입니다!" ? .green : .red)
            Text(quizViewModel.answerFeedback?.message ?? "")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding([.top, .horizontal], 20)
    }

    private var answerView: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(quizViewModel.answerFeedback?.pinyin ?? "")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Text(quizViewModel.answerFeedback?.fullSentence ?? "")
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Text(quizViewModel.answerFeedback?.translation ?? "")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.black)
        .padding(.vertical, 10)
    }

    private var nextButton: some View {
        Button(action: {
            // 다음 퀴즈로 넘어가기
            if currentIndex < (quizViewModel.quiz?.quizzes.count ?? 0) - 1 {
                currentIndex += 1
                quizViewModel.selectedOption = nil
                showModal = false
            } else {
                showCompleteView = true
            }
        }) {
            Text("다음으로")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:  .infinity, maxHeight: 50)
                .background(quizViewModel.answerFeedback?.message == "정답입니다!" ? Color.Color1 : Color.Color0)
                .cornerRadius(10)
        }
        .padding([.horizontal, .bottom])
    }
}

