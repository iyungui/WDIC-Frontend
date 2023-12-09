//
//  LessonSentencesQuizView.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

struct LessonSentencesQuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            QuizSentenceContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.adaptiveWhiteBlack.cornerRadius(20, corners: [.topLeft, .topRight]))
                .padding(.top, 5)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "문장"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
}

struct QuizSentenceContentView: View {
    @State private var currentIndex: Int = 5
    private var sentences: [Sentence] = sampleSentences
    private var totalCards: Int {
        sentences.count
    }
    private var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(totalCards)
    }
    
    @State private var quizType: SentenceQuizType = .blank
    @State private var selectedSentence: Sentence = sampleSentences.randomElement() ?? sampleSentences[0]
    
    @State private var selectedOption: Sentence?
    
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("문장 익히기 QUIZ")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.appAccent)
                    .padding(.top, 20)
                
                Group {
                    ProgressText()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 50)
                    ProgressBar(progress: .constant(progress))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 50)
                }
                
                quizTextView
                    .padding(.top, 10)
                Spacer()
                
                Spacer()
                buttonView
                    .padding(.bottom, 20)
            }
            
            if showModal {
                SentenceModalAnswerView(showModal: $showModal)
            }
        }
        .animation(.default, value: showModal)
        .edgesIgnoringSafeArea(.all)
        
        .onAppear {
            quizType = [.blank, .configuration].randomElement()!
            selectedSentence = sentences.randomElement() ?? sentences[0]
        }
    }
    private var quizTextView: some View {
        VStack {
            if quizType == .blank {
                Text("다음 빈칸 안에\n들어갈 말을 고르세요.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.darkColor)
            } else {
                Text("제시된 단어로 옳게 배치된\n문장을 고르세요.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.darkColor)
            }
        }
    }
    private var buttonView: some View {
        VStack(alignment: .center) {
            Button(action: {
                self.showModal = true
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
}

struct QuizSentenceView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
        }
    }
}

#Preview {
    LessonSentencesQuizView()
}
