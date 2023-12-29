//
//  EmailLoginView.swift
//  WDIC
//
//  Created by 이융의 on 12/16/23.
//

import SwiftUI

struct EmailLoginView: View {
    enum Field: Hashable {
        case email, password
    }
    @FocusState private var focusField: Field?

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignUpView: Bool = false
    @State private var navigateToMainView: Bool = false
    
    @EnvironmentObject var userAuthManager: UserAuthenticationManager
    
    @State private var errorMessage: String? = nil
    @State private var showErrorMessage = false

    var body: some View {
        
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                logoTitle
                    .padding(.top)
                Spacer()
                loginInput
                if (errorMessage != nil) && showErrorMessage {
                    errorMessageText
                }
                loginButton
                loginInfo
                Spacer()

            }
        }
        .onSubmit {
            switch focusField {
            case .email:
                focusField = .password
            case .password:
                handleLogin()
            default:
                break
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showSignUpView, destination: { SignUpView() })
        .navigationDestination(isPresented: $navigateToMainView, destination: { MainView().environmentObject(userAuthManager) })
    }
    func handleLogin() {
        userAuthManager.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.navigateToMainView = true  // Trigger navigation on success
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showErrorMessage = true
                }
            }
        }
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
    private var loginInput: some View {
        VStack(spacing: 20) {
            HStack {
                Text("이메일 주소")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Spacer()

            }
            
            TextField("", text: $email, prompt: Text("이메일 주소 입력").font(.system(size: 14)).foregroundColor(.white)
            )
            .frame(maxWidth: .infinity)
            .submitLabel(.next)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(8)
            
            HStack {
                Text("비밀번호")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Spacer()

            }
            
            SecureField("", text: $password, prompt: Text("비밀번호 입력").font(.system(size: 14)).foregroundColor(.white)
            )
            .frame(maxWidth: .infinity)
            .submitLabel(.next)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(8)
            
        }
        .padding(.horizontal, 40)
    }
    private var errorMessageText: some View {
        VStack {
            Text(errorMessage ?? "오류가 발생했습니다. 잠시 후 다시 시도해주세요.")
                .foregroundColor(.dark)
                .fontWeight(.semibold)
                .font(.caption)
        }
    }
    private var loginButton: some View {
        VStack {
            Button(action: {
                handleLogin()
            }) {
                Text("로그인")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 40)
    }
    private var loginInfo: some View {
        HStack {
            Button(action: {
                showSignUpView = true
            }) {
                Text("회원가입")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            Spacer()
            Text("비밀번호 찾기")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.white)

            Spacer()
            Text("고객센터")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.white)

        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    EmailLoginView()
}
