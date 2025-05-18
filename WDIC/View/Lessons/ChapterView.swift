//
//  ChapterView.swift
//  WDIC
//
//  Created by 이융의 on 11/19/23.
//

import SwiftUI

struct ChapterView: View {
    @EnvironmentObject var chapterViewModel: ChapterViewModel

    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center) {
                Image("logo_1")
                Spacer()
            }
            .offset(y: -30)
            
            VStack(spacing: 0) {
                ChapterContentView()
                    .environmentObject(chapterViewModel)
                    .offset(y: 100)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ChapterContentView: View {
    @EnvironmentObject var chapterViewModel: ChapterViewModel

    var body: some View {
        ScrollView {
            VStack {
                titleView
                Divider().padding(.horizontal, 20)
                ChapterListView().environmentObject(chapterViewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var titleView: some View {
        HStack {
            Text("今天的学习")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.Color2)
            
            Spacer()
            
            Text("Total 30")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(Color.Color10)
        }
        .padding([.top, .horizontal], 20)
    }
}

// MARK: - CHAPTER LIST VIEW

struct ChapterListView: View {
    @EnvironmentObject var chapterViewModel: ChapterViewModel

    var body: some View {
        LazyVStack {
            ForEach(chapterViewModel.chapters, id: \.id) { chapter in
                ChapterItemView(chapter: chapter)
                    .padding(.bottom, 5)
            }
        }
        .onAppear {
            // 백엔드 대신 Mock 데이터 사용
            chapterViewModel.setupMockData()
            // 원래 코드 - 필요할 때 주석 해제
            // chapterViewModel.fetchChapters()
        }
        .padding(.top, 10)
    }
}


struct ChapterItemView: View {
    
    let chapter: Chapter
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Text("\(chapter.number)")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(width: 75, height: 75, alignment: .center)
                    .background(Color.Color16)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(chapter.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color.darkColor)
                        .lineLimit(1)
                    
                    Text(chapter.description)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color.darkColor)
                        .lineLimit(2)
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image("playButton2").resizable().scaledToFit().frame(width: 40, height: 40)
                }
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            if isExpanded {
                LessonListView(lessonIds: chapter.lessons)
            }
        }
        .padding(15)
        .frame(width: UIScreen.main.bounds.width - 50)
        .background(isExpanded ? Color.Color15.opacity(0.34) : Color.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
        .animation(.easeInOut, value: isExpanded)
    }
}

/*    let details = ["나를 소개하기", "가족소개하기", "나와 가족 소개하기"]
    Text("\(detailIndex - 1)")
        .font(.caption)
        .fontWeight(.bold)
        .foregroundColor(Color.blue)*/

// 장 별 레슨 목록 보기
struct LessonListView: View {
    let lessonIds: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(lessonIds, id: \.self) { lessonId in
                HStack(spacing: 15) {
                    // Adjusted image name generation logic
                    let imageIndex = (lessonIds.firstIndex(of: lessonId) ?? -1) + 1
                    let imageName = imageIndex > 0 ? "ColorBox\(imageIndex)" : "DefaultImage"

                    Image(imageName)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Lesson \(imageIndex)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: LessonWordsView(lessonId: lessonId)) {
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
                .background(Color.white)
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
