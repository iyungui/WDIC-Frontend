//
//  UIColorSet.swift
//  WDIC
//
//  Created by 이융의 on 11/18/23.
//

import Foundation
import SwiftUI

extension Color {
    static let appAccent = Color("mainColor")
    
    
    static let Color0 = Color("Color 0")
    static let Color1 = Color("Color 1")
    static let Color2 = Color("Color 2")
    static let Color3 = Color("Color 3")
    static let Color4 = Color("Color 4")
    static let Color5 = Color("Color 5")
    static let Color6 = Color("Color 6")
    static let Color7 = Color("Color 7")
    static let Color8 = Color("Color 8")
    static let Color9 = Color("Color 9")

    static let darkColor = Color("DarkColor")


}

extension Color {
    var uiColor: UIColor {
        return UIColor(self)
    }
}

extension Color {
    static var adaptiveWhiteBlack: Color {
        Color(UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? .secondarySystemBackground : .white
        })
    }
}
