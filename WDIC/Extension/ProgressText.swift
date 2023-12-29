//
//  ProgressText.swift
//  WDIC
//
//  Created by 이융의 on 12/27/23.
//

import SwiftUI

struct ProgressText: View {
    var currentIndex: Int
    var totalCards: Int

    var body: some View {
        HStack {
            Spacer()
            Text("\(currentIndex + 1)/\(totalCards)")
                .font(.callout)
                .multilineTextAlignment(.trailing)
                .foregroundColor(Color.dark)
        }
    }
}

