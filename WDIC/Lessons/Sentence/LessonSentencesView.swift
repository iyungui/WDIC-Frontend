//
//  LessonSentencesView.swift
//  WDIC
//
//  Created by 이융의 on 11/21/23.
//

import SwiftUI

struct LessonSentencesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var sentences: [Sentence] = sampleSentences
    private var totalCards: Int {
        sampleSentences.count
    }
    private var progress: CGFloat {
        CGFloat(totalCards - sentences.count) / CGFloat(totalCards)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            titleView
            .padding(.top)

            ProgressBar(progress: .constant(progress))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 50)
            
            ListSentencesView(sentences: $sentences)
                .padding(.top)
                        
            if progress >= 1.0 {
                 nextSentenceQuizView()
                    .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NavigationViewComponent(highlightedItem: "문장"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appAccent)
    }
    private var titleView: some View {
        VStack(alignment: .center) {
            Text("문장 배우기")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color.adaptiveWhiteBlack)
        }
    }
}

struct ListSentencesView: View {
    @Binding var sentences: [Sentence]

    var body: some View {
        List {
            ForEach(sentences) { sentence in
                VStack(alignment: .center, spacing: 10) {
                    Text(sentence.content)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                    
                    Text(sentence.pinyin)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Text(sentence.meaning)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .listRowBackground(Color.appAccent)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .onDelete(perform: deleteSentence)
        }
        .listStyle(PlainListStyle())
    }

    func deleteSentence(at offsets: IndexSet) {
        sentences.remove(atOffsets: offsets)
    }
}

struct nextSentenceQuizView: View {
    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(destination: LessonSentencesQuizView()) {
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
    LessonSentencesView()
}
