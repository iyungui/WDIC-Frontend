//
//  CustomAlertView.swift
//  WDIC
//
//  Created by 이융의 on 12/30/23.
//

import SwiftUI

struct CustomAlertView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("logo_1")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text("글쓰기를 완료했습니다.")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text("커뮤니티 게시판에 질문을 업로드할까요?")
            
            HStack(spacing: 20) {
                Button(action: {
                }) {
                    Text("홈으로 가기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.Color5)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    
                }) {
                    Text("업로드 하기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.Color6)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

#Preview {
    CustomAlertView()
}
