//
//  LessonWordsView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI
import ACarousel

struct LessonWordsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentIndex: Int = 0
    private var words: [Word] = sampleWords
    private var totalCards: Int {
        words.count
    }
    private var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(totalCards)
    }

    var body: some View {
        VStack(alignment: .center) {
            titleView
                .padding(.top)

            ProgressBar(progress: .constant(progress))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)

            SliderWordCardsView(words: words, currentIndex: $currentIndex)

            Spacer()
            if progress >= 1.0 {
                nextButtonView()
                    .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "단어"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
    
    private var titleView: some View {
        VStack(alignment: .center) {
            Text("단어 익히기\n")
                .font(.system(size: 24, weight: .bold))
//                .font(.title)
//                .fontWeight(.bold)
                .foregroundColor(Color.adaptiveWhiteBlack)
        }
    }
}

struct SliderWordCardsView: View {
    let words: [Word]
    @Binding var currentIndex: Int

    var body: some View {
        GeometryReader { geometry in
            let scale: CGFloat = 0.9
            let cardWidth = min(295, geometry.size.width) * scale
            let cardHeight = cardWidth * (444 / 295)

            ACarousel(words, id: \.hanja,
                      index: $currentIndex,
                      spacing: 0,
                      headspace: (geometry.size.width - cardWidth) / 2.5,
                      sidesScaling: 0.8,
                      isWrap: false) { word in
                let cardIndex = words.firstIndex(where: { $0.hanja == word.hanja }) ?? 0
                let color = currentIndex == cardIndex ? Color.Color2 : Color.Color9
                CardView(word: word, width: cardWidth, height: cardHeight, color: color)
            }
        }
    }
}

struct CardView: View {
    var word: Word
    var width: CGFloat
    var height: CGFloat
    var color: Color

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
                
                Image(systemName: "speaker.2.fill")
                    .resizable().scaledToFit().frame(width: 25, height: 25)

                Text(word.hanja)
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

struct nextButtonView: View {
    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(destination: LessonWordsQuizView()) {
                Text("다음")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color.Color6)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }
        }
    }
}


#Preview {
    LessonWordsView()
}
