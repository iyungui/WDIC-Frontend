//
//  ChapterView.swift
//  WDIC
//
//  Created by 이융의 on 11/19/23.
//

import SwiftUI

struct ChapterView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image("BooLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)

                ChapterContentView()
                    .offset(y: -58)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
}

struct ChapterContentView: View {
    var body: some View {
        VStack {
            titleView
            
            Divider().padding(.horizontal, 10)
            
            ChapterListView()
            
            Spacer().frame(height: 100)

        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.adaptiveWhiteBlack.cornerRadius(20, corners: [.topLeft, .topRight]))
    }
    
    private var titleView: some View {
        HStack {
            Text("今天的学习")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.appAccent)
            
            Spacer()
            
            Text("Total 30")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(Color.appAccent)
        }
        .padding([.top, .horizontal], 20)
    }
}

// MARK: - CHAPTER LIST VIEW

struct ChapterListView: View {
    var body: some View {
        LazyVStack {
            ForEach(0..<10, id: \.self) { index in
                ChapterItemView(index: index)
                    .padding(.bottom, 5)
            }
        }
        .padding(.top, 10)
    }
}

struct ChapterItemView: View {
    let index: Int
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("\(index + 1)")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(width: 75, height: 75, alignment: .center)
                    .background(Color.Color5)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("自我介绍")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color.darkColor)
                        .lineLimit(1)
                    
                    Text("자기소개 및 가족 소개")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color.darkColor)
                        .lineLimit(2)
                }
                Spacer()
                Button(action: {}) {
                    Image("playButton").resizable().scaledToFit().frame(width: 40, height: 43)
                }
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                LessonListView()
            }
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width - 50)
        .background(isExpanded ? Color.Color3 : Color.adaptiveWhiteBlack)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
        .animation(.easeInOut, value: isExpanded)
    }
}

struct LessonListView: View {
    let details = ["나를 소개하기", "가족소개하기", "나와 가족 소개하기"]
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(1..<4, id: \.self) { detailIndex in
                HStack(spacing: 15) {
                    
                    Image("ColorBox\(detailIndex)").resizable().scaledToFit().frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Lessons \(detailIndex)")
                            .font(.subheadline)
                        
                        Text(details[detailIndex - 1])
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                    }
                    
                    Spacer()
                    NavigationLink(destination: LessonWordsView()) {
                        Text("학습하기")
                            .font(.caption)
                            .foregroundColor(Color(red: 0.95, green: 0.59, blue: 0.13))
                            .frame(width: 70, height: 25)
                            .background(Color(red: 0.95, green: 0.59, blue: 0.13).opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.adaptiveWhiteBlack)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
            }
        }
        .padding(10)
        .padding(.top, 10)
    }
}

#Preview {
    ChapterView()
}
