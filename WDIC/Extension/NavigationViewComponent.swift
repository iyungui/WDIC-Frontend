//
//  NavigationViewComponent.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

struct NavigationViewComponent: View {
    @Environment(\.presentationMode) var presentationMode
    var highlightedItem: String

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.adaptiveWhiteBlack)
                    .frame(width: 20, height: 20)
            }
            Spacer().frame(width: 20)
            
            Group {
                Text("단어")
                    .font(.footnote)
                    .fontWeight(highlightedItem == "단어" ? .semibold : .regular)
                    .foregroundColor(highlightedItem == "단어" ? .adaptiveWhiteBlack : .gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                Text("문장")
                    .font(.footnote)
                    .fontWeight(highlightedItem == "문장" ? .semibold : .regular)
                    .foregroundColor(highlightedItem == "문장" ? .adaptiveWhiteBlack : .gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                Text("발음")
                    .font(.footnote)
                    .fontWeight(highlightedItem == "발음" ? .semibold : .regular)
                    .foregroundColor(highlightedItem == "발음" ? .adaptiveWhiteBlack : .gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                Text("작문")
                    .font(.footnote)
                    .fontWeight(highlightedItem == "작문" ? .semibold : .regular)
                    .foregroundColor(highlightedItem == "작문" ? .adaptiveWhiteBlack : .gray)
            }
        }
    }
}

struct NavigationViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewComponent(highlightedItem: "단어")
    }
}
