//
//  LessonWriteView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonWriteView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @State private var showingAlert = false

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center)  {
                WriteContentView(showingAlert: $showingAlert)
                    .environmentObject(viewModel)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.cornerRadius(20, corners: [.topLeft, .topRight]))
                    .padding(.top, 5)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "작문"))
            
            if showingAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea(.all)
            }
            
            if showingAlert {
                CustomAlertView()
                    .environmentObject(viewModel)
                    .frame(minWidth: 300, minHeight: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .zIndex(2)
            }
            
        }
        .onAppear {
            viewModel.fetchLessonPart(partType: "writing")
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WriteContentView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    
    @State private var text: String = ""
    @State private var currentStep: Int = 0
    
    @Binding var showingAlert: Bool

    @State private var currentIndex: Int = 0
    
    private var totalCards: Int {
        viewModel.writing?.count ?? 0
    }
    
    var body: some View {
        VStack {
            if currentStep == 0 {
                InputTextView(text: $text, currentIndex: $currentIndex, totalCards: totalCards, nextStep: {
                    self.currentStep += 1
                }, previousStep: {
                    if self.currentIndex > 0 { self.currentIndex -= 1 }
                    self.currentStep = 0
                }).environmentObject(viewModel)
            } else if currentStep == 1 {
                InputtedTextView(text: $text, currentIndex: $currentIndex, totalCards: totalCards, nextStep: {
                    if self.currentIndex < totalCards - 1 {
                        self.currentIndex += 1
                        self.currentStep = 0
                        self.text = ""
                    } else {
                        self.showingAlert = true
                    }
                }, previousStep: {
                    self.currentStep -= 1
                }).environmentObject(viewModel)
            } else if currentStep == 2 {
                EmptyView()
            }
        }
        .padding()
        .padding(.vertical)
    }
}

// MARK: - INPUT TEXT VIEW

struct InputTextView: View {
    @EnvironmentObject var viewModel: LessonViewModel

    @Binding var text: String
    @Binding var currentIndex: Int
    var totalCards: Int

    var nextStep: () -> Void
    var previousStep: () -> Void
    private let placeholder = "클릭해서 본문 입력"
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                titleView
                descriptionText
//                Spacer()
                ExampleSentenceView(currentIndex: $currentIndex).environmentObject(viewModel)
//                Spacer()
                inputText
//                Spacer()
                nextButton
            }
        }
        .padding(.bottom, keyboardResponder.currentHeight)
        .animation(.easeOut(duration: 0.16))
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    private var titleView: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("작문 연습하기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.black)
            Text("\(currentIndex + 1) / \(totalCards)")
                .font(.title3)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
        }
    }

    private var descriptionText: some View {
        VStack(alignment: .center) {
            Text(viewModel.writing?[currentIndex].taskDescription ?? "Default Task Description")
                .font(.system(size: 15, weight: .light))
                .foregroundColor(.black)
                .padding(.horizontal, 20)
        }
    }
    
    private var inputText: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.Color7, lineWidth: 1)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 200)

            TextEditor(text: $text)
                .padding()
                .foregroundColor(Color.black)
                .font(.subheadline)
                .lineSpacing(5)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            if text.isEmpty {
                Text(placeholder)
                    .font(.subheadline)
                    .opacity(0.4)
                    .padding(.all)
                    .padding(.leading, 5)
                    .padding(.top, 10)
            }
        }
        .padding(.horizontal)
    }
    private var nextButton: some View {
        VStack(alignment: .center) {
            Button(action: {
                nextStep()
            }, label: {
                Text("다음")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color.Color6)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            })
        }
    }
}

struct ExampleSentenceView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Binding var currentIndex: Int

    var body: some View {
        VStack {
            headerView
            sentenceView
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.Color12)
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private var headerView: some View {
        VStack {
            Text("作文练习")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:.infinity)
                .background(Color.Color6)
        }
    }
    
    private var sentenceView: some View {
        ScrollView {
            Text(viewModel.writing?[currentIndex].exampleSentence ?? "Default Example Sentence")       // wrting.exampleSentence
                .font(.headline)
                .foregroundColor(Color.Color5)
                .multilineTextAlignment(.leading)

                .lineSpacing(8)
        }
        .padding(20)
    }
}

// MARK: - INPUTTED TEXT VIEW

struct InputtedTextView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Binding var text: String
    @Binding var currentIndex: Int
    var totalCards: Int
    
    var nextStep: () -> Void
    var previousStep: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                titleView
                VStack {
                    headerView
                    sentenceView
                    Spacer()
                    inputImageView
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.Color12)
                .cornerRadius(10)
                .padding(.horizontal)
                
                buttonView
                    .padding(.top)
            }
        }
    }
    private var titleView: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("작문 연습하기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.black)
            Text("\(currentIndex + 1) / \(totalCards)")
                .font(.title3)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
        }
    }


    private var headerView: some View {
        VStack {
            Text("作文练习")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:.infinity)
                .background(Color.Color6)
        }
    }
    private var sentenceView: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(Color.Color5)
            .multilineTextAlignment(.leading)
            .lineSpacing(8)
            .padding(20)
    }
    
    private var inputImageView: some View {
        HStack {
            Spacer()
            Image(systemName: "photo.badge.plus")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
                .foregroundColor(Color.Color5)
        }
        .padding([.trailing, .bottom])
    }
    private var buttonView: some View {
        HStack(spacing: 20) { // 간격을 여기서 조정
            Button(action: {
                previousStep()
            }, label: {
                Text("이전")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // 최대 너비를 무한대로 설정
                    .background(Color.Color7)
                    .cornerRadius(10)
            })

            Button(action: {
                nextStep()
            }, label: {
                Text("다음")
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // 최대 너비를 무한대로 설정
                    .background(Color.Color6)
                    .cornerRadius(10)
            })
        }
        .padding(.horizontal, 20) // HStack에 패딩 적용
    }
}

#Preview {
    LessonWriteView()
}
