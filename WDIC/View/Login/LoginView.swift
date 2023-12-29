//
//  LoginView.swift
//  WDIC
//
//  Created by 이융의 on 12/9/23.
//

import SwiftUI

struct LoginView: View {
    @State private var showEmailLoginView: Bool = false
    @State private var showSignUpView: Bool = false
    @EnvironmentObject var userAuthManager: UserAuthenticationManager

    var body: some View {
        NavigationStack {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .ignoresSafeArea(.all)
                
                VStack(alignment: .center) {
                    logoImage
                    logoTitle
                        .offset(y: -40)
                    loginButtonView
                }
            }
            .navigationDestination(isPresented: $showEmailLoginView, destination: { EmailLoginView().environmentObject(userAuthManager) })
            .navigationDestination(isPresented: $showSignUpView, destination: { SignUpView() })
        }
    }
    private var logoImage: some View {
        ZStack(alignment: .center) {
            Image("panda_tree")
                .resizable()
                .scaledToFit()
                .offset(x: -40)
            
            Image("logo_2")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 250, height: 250)
    }
    
    private var logoTitle: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("WDIC")
                .font(.system(size: 70, weight: .black))
                .foregroundColor(.white)
            Text("Writing Documents In Chinese")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
        }
    }
    private var loginButtonView: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                showSignUpView = true
            }) {
                Text("가입하기")
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                showEmailLoginView = true
            }) {
                Text("로그인")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    LoginView()
}
