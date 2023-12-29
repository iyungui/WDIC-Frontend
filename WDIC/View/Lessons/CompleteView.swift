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
    @EnvironmentObject var viewModel: LessonViewModel

    @State private var progress = 0.0
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Image("logo_2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
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
                    NavigationLink(destination: LessonSentencesView().environmentObject(viewModel)) {
                        Text("다음")
                            .foregroundColor(.black)
                            .padding()
                            .padding(.horizontal, 35)
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.top)
                    }
                }
                Spacer()
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "단어"))
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CompleteWordView()
}

// MARK: - SENTENCE
struct CompleteSentenceView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var progress = 0.0
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Image("logo_2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("문장 배우기를\n완료했습니다!")
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
                    NavigationLink(destination: LessonPronView().environmentObject(viewModel)) {
                        Text("다음")
                            .foregroundColor(.black)
                            .padding()
                            .padding(.horizontal, 35)
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.top)
                    }
                }
                
                Spacer()
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "문장"))
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - PRON
struct CompletePronView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var progress = 0.0
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                Image("logo_2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("발음 연습하기를\n완료했습니다!")
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
//                    NavigationLink(destination: LessonPronView().environmentObject(viewModel)) {
                        Text("다음")
                            .foregroundColor(.black)
                            .padding()
                            .padding(.horizontal, 35)
                            .background(.white)
                            .cornerRadius(10)
                            .padding(.top)
//                    }
                }
                
                Spacer()
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "발음"))
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

