//
//  LoginView.swift
//  WDIC
//
//  Created by 이융의 on 12/6/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            Text("WDIC")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
            Spacer()
            
            SignInWithAppleView()
              .frame(width: 280, height: 60, alignment: .center)
              .signInWithAppleButtonStyle(colorScheme == .light ? .black : .whiteOutline)
            
            
            
            Text("간편하게 로그인하고 바로 서비스를 이용해보세요.")
                .font(.footnote)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Color1)
    }
}

#Preview {
    LoginView()
        .preferredColorScheme(.dark)
}
