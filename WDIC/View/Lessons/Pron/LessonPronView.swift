//
//  LessonPronView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonPronView: View {
    @EnvironmentObject var viewModel: LessonViewModel

    @Environment(\.presentationMode) var presentationMode
        
    @State private var currentIndex: Int = 0
    
    private var totalCards: Int {
        viewModel.pronunciation?.count ?? 0
    }
    
    private var progress: CGFloat {
        CGFloat(currentIndex + 1) / CGFloat(totalCards)
    }
    @State private var showingCompleteView: Bool = false
    
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center) {
                Spacer()
                titleView
                .padding(.top)

                Text("\(currentIndex + 1) / \(totalCards)")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
                    .padding(.top, 5)
                                
                PronContentView(currentIndex: $currentIndex)
                    .environmentObject(viewModel)
                    .padding(.top)
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "발음"))
            
            if CGFloat(currentIndex + 1) / CGFloat(totalCards) >= 1.0 {
                CompletePronView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.fetchLessonPart(partType: "pronunciation")
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private var titleView: some View {
        VStack(alignment: .center) {
            Text("발음 연습하기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.white)
        }
    }
}

struct PronContentView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Binding var currentIndex: Int
    @State private var isSpeaking = false
    @State private var step: Int = 3
    
    var body: some View {
        VStack {
            pronText
            toolButtonView
        }
    }
    
    private var pronText: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text(viewModel.pronunciation?[currentIndex].pinyin ?? "Default pinyin")
                .font(.subheadline)
                .fontWeight(.light)
            
            Text(viewModel.pronunciation?[currentIndex].sentence ?? "Default sentence")
                .font(.headline)
            Text(viewModel.pronunciation?[currentIndex].translation ?? "Default translation")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 40)
    }

    private var feedbackText: some View {
        VStack {
            if step == 0 {
                Text("들어보세요.")
            } else if step == 1 {
                Text("따라해보세요.")
            } else if step == 2 {
                Text("다시 시도해보세요.")
            } else {
                adviceText()
            }
        }
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(.white)
    }
    
    private func adviceText() -> Text {
        return Text("참 잘했어요!")
    }
    
    private var toolButtonView: some View {
        VStack {
            Spacer()
            feedbackText
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "waveform.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.Color4)
                    
                    Spacer()
                    Button(action: {
                        isSpeaking.toggle()
                        if isSpeaking {
                            TextToSpeechManager.shared.speak(text: viewModel.pronunciation?[currentIndex].sentence ?? "Default sentence")
                        } else {
                            TextToSpeechManager.shared.stop()
                        }
                    }) {
                        Image(systemName: "record.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color.Color2)
                    }

                    Spacer()
                    
                    Button(action: {
                        self.currentIndex += 1
                    }) {
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.Color4)
                    }
                }
                .padding()
                .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}



#Preview {
    LessonPronView()
}

