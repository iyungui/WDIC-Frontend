//
//  CustomTabBar.swift
//  WDIC
//
//  Created by 이융의 on 11/19/23.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            HStack(spacing: 0) {
                ForEach(0..<5, id: \.self) { index in
                    Button(action: {
                        self.selectedTab = index
                    }) {
                        VStack {
                            Image(tabIconName(for: index, isSelected: selectedTab == index))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .background(Color.white)
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    private func tabIconName(for index: Int, isSelected: Bool) -> String {
        let baseName: String
        switch index {
        case 0: baseName = "home"
        case 1: baseName = "lessons"
        case 2: baseName = "community"
        case 3: baseName = "calendar"
        case 4: baseName = "profile"
        default: baseName = "default"
        }
        return isSelected ? "\(baseName)_selected" : "\(baseName)_unselected"
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
