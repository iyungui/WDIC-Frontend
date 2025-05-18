//
//  LessonWordsView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI
import ACarousel

struct LessonWordsView: View {
    @StateObject var viewModel: LessonViewModel

    let lessonId: String

    // Custom initializer
    public init(lessonId: String) {
        self.lessonId = lessonId
        _viewModel = StateObject(wrappedValue: LessonViewModel(lessonId: lessonId))
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentIndex: Int = 0
    
    private var totalCards: Int {
        viewModel.vocabulary?.count ?? 0
    }
    
    private var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(totalCards)
    }

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center) {
                titleView
                    .padding(.top)

                Text("\(currentIndex + 1) / \(totalCards)")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
                    .padding(.top, 5)

                SliderWordCardsView(currentIndex: $currentIndex).environmentObject(viewModel)

                Spacer()
                if CGFloat(currentIndex + 1) / CGFloat(totalCards) >= 1.0 {
                    nextWordQuizView().environmentObject(viewModel)
                        .padding(.bottom)
                }
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "단어"))
        }
        .onAppear {
            // 백엔드 대신 Mock 데이터 사용
            viewModel.setupMockData()
            // 원래 코드 - 필요할 때 주석 해제
            // viewModel.fetchLessonPart(partType: "vocabulary")
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var titleView: some View {
        VStack(alignment: .center) {
            Text("단어 익히기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.white)
        }
    }
}

struct SliderWordCardsView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Binding var currentIndex: Int

    var body: some View {
        GeometryReader { geometry in
            let scale: CGFloat = 0.9
            let cardWidth = min(295, geometry.size.width) * scale
            let cardHeight = cardWidth * (444 / 295)

            // Use vocabulary from viewModel if available
            if let vocabularyWords = viewModel.vocabulary {
                ACarousel(vocabularyWords, id: \.word,
                          index: $currentIndex,
                          spacing: 0,
                          headspace: (geometry.size.width - cardWidth) / 2.5,
                          sidesScaling: 0.8,
                          isWrap: false) { word in
                    let cardIndex = vocabularyWords.firstIndex(where: { $0.word == word.word }) ?? 0
                    let color = currentIndex == cardIndex ? .white : Color.Color9
                    CardView(word: word, width: cardWidth, height: cardHeight, color: color)
                }
            } else {
                // Handle loading or empty states
                Text(viewModel.isLoading ? "Loading..." : "No words available")
            }
        }
    }
}


struct CardView: View {
    var word: Vocabulary
    var width: CGFloat
    var height: CGFloat
    var color: Color
    @State private var isSpeaking = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                Text(word.pinyin)
                    .font(.title3)
                    .kerning(0.4)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    isSpeaking.toggle()
                    if isSpeaking {
                        TextToSpeechManager.shared.speak(text: word.word)
                    } else {
                        TextToSpeechManager.shared.stop()
                    }
                }) {
                    Image(systemName: "speaker.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.Color6)
                }

                Text(word.word)
                    .font(.system(size: 45, weight: .bold))
                    .kerning(0.9)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Text(word.meaning)
                    .font(.title3)
                    .kerning(0.4)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            .padding(30)
        }
        .frame(width: width, height: height)
    }
}

struct nextWordQuizView: View {
    @EnvironmentObject var viewModel: LessonViewModel

    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(destination: LessonWordsQuizView().environmentObject(viewModel)) {
                Text("다음")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color.Color2)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
        }
    }
}


