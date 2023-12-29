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
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
            }
            Spacer().frame(width: 20)
            
            Group {
                Text("단어")
                    .font(highlightedItem == "단어" ? .title3 : .footnote)
                    .fontWeight(highlightedItem == "단어" ? .bold : .regular)
                    .foregroundColor(highlightedItem == "단어" ? Color.white : Color.white.opacity(0.5))

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                Text("문장")
                    .font(highlightedItem == "문장" ? .title3 : .footnote)
                    .fontWeight(highlightedItem == "문장" ? .bold : .regular)
                    .foregroundColor(highlightedItem == "문장" ? Color.white : Color.white.opacity(0.5))
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                Text("발음")
                    .font(highlightedItem == "발음" ? .title3 : .footnote)
                    .fontWeight(highlightedItem == "발음" ? .bold : .regular)
                    .foregroundColor(highlightedItem == "발음" ? Color.white : Color.white.opacity(0.5))
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                Text("작문")
                    .font(highlightedItem == "작문" ? .title3 : .footnote)
                    .fontWeight(highlightedItem == "작문" ? .bold : .regular)
                    .foregroundColor(highlightedItem == "작문" ? Color.white : Color.white.opacity(0.5))
            }
        }
    }
}

struct NavigationViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewComponent(highlightedItem: "단어")
    }
}
