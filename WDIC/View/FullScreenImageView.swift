//
//  FullScreenImageView.swift
//  WDIC
//
//  Created by 이융의 on 12/30/23.
//

import SwiftUI

struct FullScreenImageView: View {
    let imageName: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .background(.black)
    }
}

#Preview {
    FullScreenImageView(imageName: "image1")
}
