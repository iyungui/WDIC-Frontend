//
//  CompleteView.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

// MARK: - WORD
struct CompleteWordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var progress = 0.0
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Spacer()
            Image("BooLogo2")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("단어 익히기를\n완료했습니다!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ProgressBar(progress: .constant(progress))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.progress = 1.0
                    }
                }
            
            if self.progress >= 1.0 {
                NavigationLink(destination: LessonSentencesView()) {
                    Text("다음")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 15)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.top)
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "단어"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
}

#Preview {
    CompleteWordView()
}

// MARK: - SENTENCE
struct CompleteSentenceView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var progress = 0.0
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Spacer()
            Image("BooLogo2")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("문장 익히기를\n완료했습니다!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ProgressBar(progress: .constant(progress))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.progress = 1.0
                    }
                }
            
            if self.progress >= 1.0 {
//                NavigationLink(destination: LessonSentencesView()) {
                    Text("다음")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal, 15)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.top)
//                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "문장"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
}
