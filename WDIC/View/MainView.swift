//
//  MainView.swift
//  WDIC
//
//  Created by 이융의 on 11/19/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0
    @EnvironmentObject var userAuthManager: UserAuthenticationManager
    @StateObject var userViewModel = UserViewModel()
    @StateObject var chapterViewModel = ChapterViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                selectedView(for: selectedTab)
                
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

    @ViewBuilder
    private func selectedView(for index: Int) -> some View {
        switch index {
        case 0:
            HomeView()
                .environmentObject(userAuthManager)
                .environmentObject(userViewModel)
                .environmentObject(chapterViewModel)
            
        case 1:
            ChapterView()
                .environmentObject(chapterViewModel)
        case 2:
            CommunityView()
        case 3:
            CalendarView()
        case 4:
            ProfileView()
                .environmentObject(userAuthManager)
                .environmentObject(userViewModel)
        default:
            Text("Content of Tab \(index)")
        }
    }
    
    private func onAppear() {
        if (userAuthManager.isUserAuthenticated) {
            userViewModel.getProfile(userId: nil)
        } else {
            print("No Authorization Token Found for Login")
        }
    }
}





#Preview {
    ProfileView()
}
