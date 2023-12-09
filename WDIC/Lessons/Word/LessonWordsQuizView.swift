//
//  LessonWordsQuizView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonWordsQuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            QuizWordContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.adaptiveWhiteBlack.cornerRadius(20, corners: [.topLeft, .topRight]))
                .padding(.top, 5)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "단어"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
}

struct QuizWordContentView: View {
    @State private var currentIndex: Int = 5
    private var words: [Word] = sampleWords
    private var totalCards: Int {
        words.count
    }
    private var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(totalCards)
    }
    
    @State private var quizType: QuizType = .meaningToHanja
    @State private var selectedWord: Word = sampleWords.randomElement() ?? sampleWords[0]
    @State private var selectedOption: Word?
    
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("단어 익히기 QUIZ")
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
                QuizWordsView(words: words, quizType: quizType, selectedWord: selectedWord, selectedOption: $selectedOption)
                Spacer()
                
                buttonView
                    .padding(.bottom, 20)
            }
            if showModal {
                ModalAnswerView(showModal: $showModal)
//                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.default, value: showModal)
        .edgesIgnoringSafeArea(.all)
        
 

        .onAppear {
            quizType = [.meaningToHanja, .hanjaToMeaning].randomElement()!
            selectedWord = words.randomElement() ?? words[0]
        }
    }

    private var quizTextView: some View {
        VStack {
            if quizType == .meaningToHanja {
                Text("‘\(selectedWord.meaning)’\n를(을) 고르세요.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.darkColor)
            } else {
                Text("‘\(selectedWord.hanja)’의 뜻을(를) 고르세요.")
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

struct ProgressText: View {
    var body: some View {
        HStack {
            Spacer()
            Text("5/10")
                .font(.caption)
                .multilineTextAlignment(.trailing)
                .foregroundColor(Color(red: 0, green: 0.18, blue: 0.33))
        }
    }
}

struct QuizWordsView: View {
    let words: [Word]
    let quizType: QuizType
    let selectedWord: Word
    let colors: [Color] = [Color.Color5, Color.Color3, Color.Color0, Color.Color1]
    @Binding var selectedOption: Word?

    var answerOptions: [Word] {
        var options = words.filter { $0.hanja != selectedWord.hanja }.shuffled()
        options = Array(options.prefix(3))
        options.append(selectedWord)
        return options.shuffled()
    }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ForEach(0..<2, id: \.self) { row in
                HStack(spacing: 20) {
                    ForEach(0..<2, id: \.self) { column in
                        let word = answerOptions[row * 2 + column]
                        wordCard(word: word, color: colors[row * 2 + column])
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 30)
    }

    func wordCard(word: Word, color: Color) -> some View {
        Text(quizType == .meaningToHanja ? word.hanja : word.meaning)
            .font(.headline)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.22))
            .frame(width: 150, height: 170)
            .background(color)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selectedOption == word ? Color.Color6 : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                selectedOption = word
            }
    }
}


#Preview {
    LessonWordsQuizView()
}
