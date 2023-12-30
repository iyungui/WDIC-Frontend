//
//  CalendarView.swift
//  WDIC
//
//  Created by 이융의 on 12/30/23.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            Image("backgroundImage")
                .resizable()
                .ignoresSafeArea(.all)
            Text("CalendarView Tab Content")
        }
    }
}




#Preview {
    CalendarView()
}

