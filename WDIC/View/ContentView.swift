//
//  ContentView.swift
//  WDIC
//
//  Created by 이융의 on 11/15/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userAuthManager: UserAuthenticationManager

    var body: some View {
        Group {
//            if userAuthManager.isUserAuthenticated {
                MainView().environmentObject(userAuthManager)
//            } else {
//                LoginView().environmentObject(userAuthManager)
//            }
        }
        .onAppear(perform: userAuthManager.validateToken)
    }
}
