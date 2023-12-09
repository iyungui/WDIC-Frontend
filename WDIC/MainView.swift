//
//  MainView.swift
//  WDIC
//
//  Created by 이융의 on 11/19/23.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Int = 0

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
    }

    @ViewBuilder
    private func selectedView(for index: Int) -> some View {
        switch index {
        case 0:
            HomeView()
        case 1:
            ChapterView()
        case 2:
            CommunityView()
        case 3:
            CalendarView()
        case 4:
            ProfileView()
        default:
            Text("Content of Tab \(index)")
        }
    }
}

struct CommunityView: View {
    var body: some View {
        Text("CommunityView Tab Content")
    }
}

struct CalendarView: View {
    var body: some View {
        Text("CalendarView Tab Content")
    }
}

struct ProfileView: View {
    var body: some View {
        Text("ProfileView Tab Content")
    }
}

#Preview {
    MainView()
}
