//
//  WDICApp.swift
//  WDIC
//
//  Created by 이융의 on 11/15/23.
//

import SwiftUI

@main
struct WDICApp: App {
//    init() {
//        Thread.sleep(forTimeInterval: 2)
//    }
    
    @StateObject var userAuthManager = UserAuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userAuthManager)
        }
    }
}
