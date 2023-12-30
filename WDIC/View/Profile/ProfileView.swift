//
//  ProfileView.swift
//  WDIC
//
//  Created by 이융의 on 12/30/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userAuthManager: UserAuthenticationManager
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                userAuthManager.logout { result in
                    if case .failure(let error) = result {
                        print("로그아웃 실패: \(error.localizedDescription)")
                    }
                }
            }, label: {
                Text("로그아웃")
            })
            
        }
    }
}

#Preview {
    ProfileView()
}
