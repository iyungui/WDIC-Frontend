//
//  HomeView.swift
//  WDIC
//
//  Created by 이융의 on 11/19/23.
//

import SwiftUI
import ACarousel

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 20)

                quoteToday

                Spacer().frame(height: 80)
                
                ZStack(alignment: .top) {
                    HomeContentView()
                    ProgressCardView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }

    private var quoteToday: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("你好。")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("오늘의 사자성어, 한 문장 등.. ")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(20)
    }
}

// MARK: - PROGRESS CARD VIEW

struct ProgressCardView: View {
    @State var progress: CGFloat = 0.5
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            cardContent
            cardProgress
            progressBar
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width - 40, alignment: .top)
        .background(Color.adaptiveWhiteBlack)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .offset(y: -75)
    }
    
    private var cardContent: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("여기까지 공부했어요!")
                    .font(.system(size: 18, weight: .regular))
                
                Text("CHAPTER 1. MBTI (2) ")
                    .font(.system(size: 13, weight: .bold))
            }
            Spacer()
            Text("계속해서\n진행하기")
              .font(Font.custom("Inter", size: 10))
              .multilineTextAlignment(.trailing)
              .foregroundColor(Color.appAccent)
              .frame(width: 60, alignment: .topTrailing)
            
            Button(action: {
                
            }) {
                Image("playButton").resizable().scaledToFit().frame(width: 50, height: 50)
            }
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    private var cardProgress: some View {
        HStack(alignment: .center, spacing: 15) {
            
            HStack(alignment: .top, spacing: 10) {
                HStack(alignment: .center, spacing: 10) {
                    Image("award")
                        .padding(7.5)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.98))
                        .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text("배움 완료 단계")
                          .font(Font.custom("Inter", size: 10))
                          .foregroundColor(Color.appAccent)
                          .frame(width: 95, alignment: .topLeading)
                        Text("50%")
                          .font(Font.custom("Inter", size: 14))
                          .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.1))
                          .frame(width: 95, alignment: .topLeading)
                    }
                }
            }
            Spacer()
            HStack(alignment: .top, spacing: 10) {
                HStack(alignment: .center, spacing: 10) {
                    Image("award")
                        .padding(7.5)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.98))
                        .cornerRadius(10)
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text("복습 완료 단계")
                          .font(Font.custom("Inter", size: 10))
                          .foregroundColor(Color.appAccent)
                          .frame(width: 95, alignment: .topLeading)
                        Text("50%")
                          .font(Font.custom("Inter", size: 14))
                          .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.1))
                          .frame(width: 95, alignment: .topLeading)
                    }
                }
            }
            
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width, height: 15)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.98))
                    .cornerRadius(25)

                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width * progress, height: 15)
                    .background(Color.appAccent)
                    .cornerRadius(25)
                    .animation(.linear, value: progress)
            }
        }
        .frame(height: 15)
    }
}

// MARK: - HOME CONTENT VIEW

struct HomeContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 100)
            
            textHeader(title: "바로가기")
            
            HomeSliderCardsView()
            
            textHeader(title: "복습하기")
            
            HomeReviewView()
            
            Spacer().frame(height: 120) // custom tabbar 공간

        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.adaptiveWhiteBlack.cornerRadius(20, corners: [.topLeft, .topRight]))
    }
    
    private func textHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(Font.custom("Inter", size: 18))
                .foregroundColor(Color(red: 0, green: 0.18, blue: 0.33))

            Spacer()

            Rectangle()
                .foregroundColor(Color.Color5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: 22)
        .padding(.horizontal, 20)
    }
}

struct CarouselItem: Identifiable {
    let id = UUID()
    let index: Int
}

struct HomeSliderCardsView: View {
    let items = (0..<10).map { CarouselItem(index: $0) }
    @State private var currentIndex: Int = 0

    var body: some View {
        GeometryReader { geometry in
            ACarousel(items, id: \.id,
                      index: $currentIndex,
                      spacing: -20,
                      headspace: (geometry.size.width - 295) / 2,
                      sidesScaling: 0.8,
                      isWrap: false) { item in
                self.cardView(item: item)

            }
        }
        .frame(height: 210)

        PageIndicator(index: currentIndex, max: items.count)
    }
    
    private func cardView(item: CarouselItem) -> some View {
        ZStack {
            // Background and styling
            RoundedRectangle(cornerRadius: 20)
                .fill(item.index == currentIndex ? Color.Color2 : Color.Color5)
                .shadow(color: item.index == currentIndex ? .black.opacity(0.25) : .clear, radius: 2, x: 0, y: 4)
                .frame(width: 295, height: 185)

            // Content
            VStack {
                // Align to the top left
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Chapter \(item.index + 1)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)

                        Text("自我介绍 (\(item.index + 1))")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.leading, 10)
                Spacer()
            }
            .padding(30)

            // Bottom right image
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("chapterLogo 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 163, height: 146)
                }
                .padding([.trailing, .top], 20)
            }
            .padding(.trailing, 20)
        }
    }

}

struct PageIndicator: View {
    var index: Int
    var max: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<max, id: \.self) { i in
                RoundedRectangle(cornerRadius: 4)
                    .fill(i == index ? Color.Color2 : Color.Color5)
                    .frame(width: i == index ? 16 : 8, height: 8)
            }
        }
        .padding(.bottom, 10)
    }
}

struct HomeReviewView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            reviewTitle
            
            reviewWord
            reviewQuote
            reviewPron
            reviewWrite
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width - 60, height: 465, alignment: .top)
        .background(Color.adaptiveWhiteBlack)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
    
    private var reviewTitle: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("복습은 최고의 학습 도구 입니다.")
                    .font(.system(size: 15))
                Text("CHAPTER 1. MBTI (2) ")
                    .font(.system(size: 12, weight: .bold))
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            
            Spacer()
            Button(action: {}) {
                Image("playButton2").resizable().scaledToFit().frame(width: 40, height: 43)
            }
        }
        .padding(10)
    }
    
    private var reviewWord: some View {
        HStack(spacing: 15) {
            Image("reviewWord").resizable().scaledToFit().frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text("复习单词")
                    .font(.headline)
                    .foregroundColor(Color.appAccent)
                Text("단어 복습")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            Text("18/25")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.appAccent)
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width - 100, height: 65)
        .background(Color.Color5)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 10)
    }
    
    private var reviewQuote: some View {
        HStack(spacing: 15) {
            Image("reviewQuote").resizable().scaledToFit().frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text("复习句子")
                    .font(.headline)
                    .foregroundColor(Color.appAccent)
                Text("문장 복습")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            Text("8/15")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.appAccent)
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width - 100, height: 65)
        .background(Color.Color3)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 10)
    }
    
    private var reviewPron: some View {
        HStack(spacing: 15) {
            Image("reviewPron").resizable().scaledToFit().frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text("复习发音")
                    .font(.headline)
                    .foregroundColor(Color.appAccent)
                Text("발음 복습")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            Text("10/10")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.appAccent)
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width - 100, height: 65)
        .background(Color.Color0)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 10)
    }
    
    private var reviewWrite: some View {
        HStack(spacing: 15) {
            Image("reviewWrite").resizable().scaledToFit().frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text("复习写作")
                    .font(.headline)
                    .foregroundColor(Color.appAccent)
                Text("쓰기 복습")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            Text("1/3")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.appAccent)
        }
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width - 100, height: 65)
        .background(Color.Color8)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 10)
    }
}

#Preview {
    HomeView()
}
