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
    static let Color10 = Color("Color 10")
    static let Color11 = Color("Color 11")
    static let Color12 = Color("Color 12")
    static let Color13 = Color("Color 13")
    static let Color14 = Color("Color 14")
    static let Color15 = Color("Color 15")
    static let Color16 = Color("Color 16")

    static let darkColor = Color("DarkColor")


}

extension Color {
    var uiColor: UIColor {
        return UIColor(self)
    }
}
