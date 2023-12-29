//
//  SignUpView.swift
//  WDIC
//
//  Created by 이융의 on 12/16/23.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 30) {
                Spacer()
                logoTitle
                Spacer()
                SignUpStepView()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
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
}

struct SignUpStepView: View {
    @StateObject var viewModel = SignUpViewModel()

    @State private var termsAccepted: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var verifyCode: String = ""
    @State private var currentStep: Int = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            if currentStep == 0 {
                TermsAndConditionsView(termsAccepted: $termsAccepted, nextStep: {
                    if termsAccepted {
                        self.currentStep += 1
                    }
                })
            } else if currentStep == 1 {
                SignUpInputView(email: $email, password: $password, nextStep: {
                    self.currentStep += 1
                }, previousStep: {
                    self.currentStep -= 1
                })
            } else if currentStep == 2 {
                SignUpNameView(email: $email, name: $name, nextStep: {
                    self.currentStep += 1
                }, previousStep: {
                    self.currentStep -= 1
                }).environmentObject(viewModel)
            }
            else if currentStep == 3 {
                SignUpVerifyView(email: $email, password: $password, name: $name, verifyCode: $verifyCode, nextStep: {
                    self.currentStep += 1
                }, previousStep: {
                    self.currentStep -= 1
                }).environmentObject(viewModel)
            } else if currentStep == 4 {
                SignUpCompletionView()
            }
        }
    }
}

#Preview {
    SignUpView()
}


struct CheckBoxView: View {
    @Binding var isAllChecked: Bool
    @State private var isTermsChecked: Bool = false
    @State private var isPrivacyChecked: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                isAllChecked.toggle()
                isTermsChecked = isAllChecked
                isPrivacyChecked = isAllChecked
            }) {
                HStack {
                    Image(systemName: isAllChecked ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 18, height: 18)

                    Text("약관 전체동의")
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .foregroundColor(Color.white)
            
            Divider()
                .background(Color.appAccent)
            
            Button(action: {
                isTermsChecked.toggle()
                updateAllCheckedStatus()
            }) {
                HStack {
                    Image(systemName: isTermsChecked ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 18, height: 18)

                    Text("이용약관 동의 (필수)")
                        .font(.system(size: 14, weight: .regular))
                }
            }
            .foregroundColor(Color.white)

            Button(action: {
                isPrivacyChecked.toggle()
                updateAllCheckedStatus()
            }) {
                HStack {
                    Image(systemName: isPrivacyChecked ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 18, height: 18)

                    Text("개인정보 수집 및 이용 동의 (필수)")
                        .font(.system(size: 14, weight: .regular))
                }
            }
            .foregroundColor(Color.white)
        }
        .padding(.bottom)
    }
    
    private func updateAllCheckedStatus() {
        isAllChecked = isTermsChecked && isPrivacyChecked
    }
}

struct TermsAndConditionsView: View {
    @Binding var termsAccepted: Bool
    var nextStep: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Text("회원가입 전, WDIC 약관을 확인해주세요.")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        
            CheckBoxView(isAllChecked: $termsAccepted)
                .padding()
            
            Button(action: nextStep) {
                Text("다음")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(termsAccepted ? Color.white : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(!termsAccepted)
        }
        .padding(.horizontal, 40)

    }
}

struct SignUpInputView: View {
    @Binding var email: String
    @Binding var password: String

    @State private var showErrorMessage = false
    var nextStep: () -> Void
    var previousStep: () -> Void
    
    enum Field: Hashable {
        case email
        case password
    }
    @FocusState private var focusField: Field?
    
    // 이메일 형식 검사
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // 비밀번호 형식 검사
    var isPasswordValid: Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }


    var body: some View {
        VStack(spacing: 20) {
            backButton

            inputEmail
            
            inputPW
            errorMessage
            nextButton
        }
        .onAppear {
            focusField = .email
        }
        .onSubmit {
            switch focusField {
            case .email:
                focusField = .password
            case .password:
                nextAction()
            default:
                break
            }
        }
        .padding(.horizontal, 40)
    }
    private var backButton: some View {
        HStack {
            Button(action: previousStep) {
                Image(systemName: "chevron.backward")
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.bottom)
    }
    private var inputEmail: some View {
        VStack {
            HStack {
                Text("이메일을 입력하세요.")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Spacer()

            }
            
            TextField("", text: $email, prompt: Text("이메일 주소").font(.system(size: 14)).foregroundColor(.white)
            )
            .frame(maxWidth: .infinity)
            .submitLabel(.next)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(8)
        }
    }
    private var inputPW: some View {
        VStack {
            HStack {
                Text("비밀번호를 입력하세요.")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Spacer()

            }
            
            SecureField("", text: $password, prompt: Text("영문, 숫자를 조합한 8~20글자").font(.system(size: 14)).foregroundColor(.white)
            )
            .frame(maxWidth: .infinity)
            .submitLabel(.next)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(8)
        }
    }
    private var errorMessage: some View {
        Group {
            if !isEmailValid && showErrorMessage && (focusField == .email || focusField == nil) {
                Text("이메일 형식을 입력하세요. 예) example@example.com")
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .font(.caption)
            } else if !isPasswordValid && showErrorMessage && (focusField == .password || focusField == nil) {
                Text("영문, 숫자를 조합한 8~20글자의 비밀번호를 입력하세요.")
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        }
    }
    private var nextButton: some View {
        Button(action: nextAction) {
            Text("다음")
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding()
                .background(fieldsFilled ? Color.white : Color.gray)
                .cornerRadius(10)
        }
        .disabled(!fieldsFilled)
    }
    private var fieldsFilled: Bool {
        !email.isEmpty && !password.isEmpty
    }
    private func nextAction() {
        if isEmailValid && isPasswordValid {
            showErrorMessage = false
            focusField = nil
            nextStep()
        } else {
            showErrorMessage = true
            if !isEmailValid {
                focusField = .email
            } else {
                focusField = .password
            }
        }
    }
}

struct SignUpNameView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @Binding var email: String
    @Binding var name: String
    private var isFormComplete: Bool {
        !name.isEmpty
    }
    
    var nextStep: () -> Void
    var previousStep: () -> Void
    @State private var errorMessage: String? = nil
    @State private var showErrorMessage = false

    enum Field: Hashable {
        case name
    }
    
    @FocusState private var focusField: Field?
    
    var body: some View {
        VStack(spacing: 20) {
            backButton
            inputName
            errorMessageText
            nextButton
        }
        .padding(.horizontal, 40)
        .onAppear {
            focusField = .name
        }
        .onSubmit {
            switch focusField {
            case .name:
                nextAction()
            default:
                break
            }
        }
    }
    private var backButton: some View {
        HStack {
            Button(action: previousStep) {
                Image(systemName: "chevron.backward")
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.bottom)
    }
    private var inputName: some View {
        VStack {
            HStack {
                Text("이름(별명)을 입력하세요.")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
            }
            
            TextField("", text: $name, prompt: Text("사용 할 이름 (별명)").font(.system(size: 14)).foregroundColor(.white)
            )
            .frame(maxWidth: .infinity)
            .submitLabel(.next)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding()
            .background(Color.white.opacity(0.5))
            .cornerRadius(8)
        }
    }
    private var errorMessageText: some View {
        VStack {
            if showErrorMessage && (errorMessage != nil) {
                Text(errorMessage ?? "")
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        }
    }
    private var nextButton: some View {
        Button(action: nextAction) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text("다음")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(isFormComplete ? Color.white : Color.gray)
                    .cornerRadius(10)
            }
        }
        .disabled(!isFormComplete || viewModel.isLoading)
    }
    private func nextAction() {
        if isFormComplete {
            showErrorMessage = false
            focusField = nil
            viewModel.sendVerificationCode(email: email) { success in
                if success {
                    nextStep()
                } else {
                    showErrorMessage = true
                    errorMessage = "해당 이메일에 인증번호를 보내는 데 실패했습니다. 다시 시도해주세요."
                }
            }
        } else {
            showErrorMessage = true
            errorMessage = "오류가 발생했습니다. 잠시 후 다시 시도해주세요."
        }
    }
}

struct SignUpVerifyView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var verifyCode: String
    
    enum Field: Hashable {
        case verifyCode
    }
    
    @FocusState private var focusField: Field?
    
    var nextStep: () -> Void
    var previousStep: () -> Void
    
    @State private var errorMessage: String? = nil
    @State private var showErrorMessage = false
    
    var body: some View {
        VStack(spacing: 20) {
            backButton
            inputVerifyCode
            errorMessageText
            nextButton
        }
        .padding(.horizontal, 40)
        .onAppear {
            focusField = .verifyCode
        }
        
        .onSubmit {
            switch focusField {
            case .verifyCode:
                nextAction()
            default:
                break
            }
        }
    }
    private var backButton: some View {
        HStack {
            Button(action: previousStep) {
                Image(systemName: "chevron.backward")
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.bottom)
    }
    private var inputVerifyCode: some View {
        VStack {
            HStack {
                if !verifyCode.isEmpty && viewModel.isEmailVerified {
                    Text("인증이 완료되었습니다.")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                } else {
                    Text("메일로 전송된 인증번호를 입력해주세요.")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                }
                Spacer()
            }

            HStack(spacing: 10) {
                TextField("", text: $verifyCode, prompt: Text("인증번호").font(.system(size: 14)).foregroundColor(.white))
                    .frame(maxWidth: .infinity)
                    .submitLabel(.next)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(8)
                    .disabled(viewModel.isEmailVerified) // Optional: Disable editing if verified

                if viewModel.isEmailVerified {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .transition(.scale) // Add a transition effect
                }
            }
            .animation(.easeInOut, value: viewModel.isEmailVerified)
        }
    }
    private var errorMessageText: some View {
        VStack {
            if showErrorMessage && (errorMessage != nil) {
                Text(errorMessage ?? "")
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        }
    }
    private var nextButton: some View {
        Button(action: nextAction) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(viewModel.isEmailVerified ? "가입하기" : "인증하기")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(determineButtonBackground())
                    .cornerRadius(10)
            }
        }
        .disabled(determineButtonDisabledState())
    }
    
    private func determineButtonBackground() -> Color {
        if viewModel.isLoading {
            return Color.gray
        } else if viewModel.isEmailVerified {
            return Color.Color1
        } else {
            return verifyCode.isEmpty ? Color.white : Color.Color6
        }
    }
    
    private func determineButtonDisabledState() -> Bool {
        if viewModel.isLoading {
            return true
        } else if viewModel.isEmailVerified {
            return false
        } else {
            return verifyCode.isEmpty
        }
    }
    
    private func nextAction() {
        if !viewModel.isEmailVerified && !viewModel.isLoading {
            viewModel.verifyEmailCode(email: email, verifyCode: verifyCode) { success in
                DispatchQueue.main.async {
                    if success {
                        viewModel.isEmailVerified = true
                    } else {
                        showErrorMessage = true
                        errorMessage = "인증번호가 잘못되었습니다."
                    }
                }
            }
        } else if viewModel.isEmailVerified {
                focusField = nil
            viewModel.registerUser(email: email, password: password, name: name) { success in
                if success {
                    nextStep()
                } else {
                    showErrorMessage = true
                    errorMessage = "회원가입 중 오류가 발생했습니다."
                }
            }
        }
    }
}

struct SignUpCompletionView: View {
    @State private var showLoginView: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            logoImage
            logoTitle
            nextButton
        }
        .padding(.horizontal, 40)
        .navigationDestination(isPresented: $showLoginView, destination: { EmailLoginView() })
    }
    private var logoImage: some View {
        ZStack(alignment: .center) {
            Image("panda_tree")
                .resizable()
                .scaledToFit()
                .offset(x: -40)
            
            Image("logo_1")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 200, height: 200)
    }
    
    private var logoTitle: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("회원가입을 완료하였습니다.")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("가입한 이메일로 로그인을 진행해주세요.")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
        }
    }
    private var nextButton: some View {
        VStack {
            Button(action: {
                showLoginView = true
            }) {
                Text("시작하기")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}
