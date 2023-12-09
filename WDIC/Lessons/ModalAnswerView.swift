//
//  ModalAnswerView.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

struct ModalAnswerView: View {
    @Binding var showModal: Bool

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .center, spacing: 20) {
                titleView
                answerView
                nextButton
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
    }
    private var titleView: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title3)
                .foregroundColor(.white)
            Text("정답입니다!")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
        .padding([.top, .trailing], 20)
    }
    private var answerView: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Cídiǎn")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Text("词典")
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Text("사전")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

        }
        .padding(.vertical, 10)
    }
    private var nextButton: some View {
        NavigationLink(destination: CompleteWordView()) {
            Text("다음으로")
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.white)
                .cornerRadius(10)
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    ModalAnswerView(showModal: .constant(true))
}

struct SentenceModalAnswerView: View {
    @Binding var showModal: Bool

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .center, spacing: 20) {
                titleView
                answerView
                nextButton
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
    }
    private var titleView: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title3)
                .foregroundColor(.white)
            Text("정답입니다!")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
        .padding([.top, .trailing], 20)
    }
    private var answerView: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Cídiǎn")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Text("词典")
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Text("사전")
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

        }
        .padding(.vertical, 10)
    }
    private var nextButton: some View {
        NavigationLink(destination: CompleteSentenceView()) {
            Text("다음으로")
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.white)
                .cornerRadius(10)
        }
        .padding([.horizontal, .bottom])
    }
}
