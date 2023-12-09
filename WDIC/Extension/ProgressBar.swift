//
//  ProgressBar.swift
//  WDIC
//
//  Created by 이융의 on 11/22/23.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: CGFloat // 0.0에서 1.0 사이의 값

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // 배경
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 15)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.98))
                    .cornerRadius(25)

                // 진행 막대
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: min(geometry.size.width * progress, geometry.size.width), height: 15)
                    .background(Color.Color6)
                    .cornerRadius(25)
            }
        }
        .frame(height: 15)
    }
}
