//
//  LessonSentencesView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonSentencesView: View {
    @EnvironmentObject var viewModel: LessonViewModel

    @Environment(\.presentationMode) var presentationMode
        
    @State private var currentIndex: Int = 0

    private var totalCards: Int {
        viewModel.sentences?.count ?? 0
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
                
                ListSentencesView(currentIndex: $currentIndex).environmentObject(viewModel)
                    .padding(.top)
                            
                if CGFloat(currentIndex + 1) / CGFloat(totalCards) > 1.0 {
                    nextSentenceQuizView().environmentObject(viewModel)
                        .padding(.bottom)
                }
            }
            .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "문장"))
        }
        .onAppear {
            // 백엔드 대신 Mock 데이터 사용
            viewModel.setupMockData()
            // 원래 코드 - 필요할 때 주석 해제
            // viewModel.fetchLessonPart(partType: "sentences")
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private var titleView: some View {
        VStack(alignment: .center) {
            Text("문장 배우기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.white)
        }
    }
}

struct ListSentencesView: View {
    @EnvironmentObject var viewModel: LessonViewModel
    @Binding var currentIndex: Int
    @State private var isSpeaking = false

    var body: some View {
        List {
            // Using viewModel.sentences instead of the binding sentences
            ForEach(viewModel.sentences ?? [], id: \.id) { sentence in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(sentence.fullSentence)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.Color6)
                            .multilineTextAlignment(.center)
                        Spacer()
                        
                        Button(action: {
                            isSpeaking.toggle()
                            if isSpeaking {
                                TextToSpeechManager.shared.speak(text: sentence.fullSentence)
                            } else {
                                TextToSpeechManager.shared.stop()
                            }
                        }) {
                            Image(systemName: "speaker.2.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.Color4)
                        }
                    }
                    
                    Text(sentence.pinyin)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Text(sentence.translation)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .listRowBackground(Color.clear)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .onDelete(perform: deleteSentence)
        }
        .listStyle(PlainListStyle())
    }

    func deleteSentence(at offsets: IndexSet) {
        // Updating the viewModel's sentences array
        viewModel.sentences?.remove(atOffsets: offsets)
    }
}


struct nextSentenceQuizView: View {
    @EnvironmentObject var viewModel: LessonViewModel

    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(destination: LessonSentencesQuizView().environmentObject(viewModel)) {
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

#Preview {
    LessonSentencesView()
}
