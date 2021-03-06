//
//  UIColor+.swift
//  Minimum
//
//  Created by 김응철 on 2022/05/27.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
            )
        }
    
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
            )
        }
}

extension UIColor {
    static func getDarkGreen() -> UIColor {
        return UIColor.init(rgb: 0x062C30)
    }
    
    static func getGray() -> UIColor {
        return UIColor.init(rgb: 0x05595B)
    }
    
    static func getOrange() -> UIColor {
        return UIColor.init(rgb: 0xE2D784)
    }

    static func getWhite() -> UIColor {
        return UIColor.init(rgb: 0xF5F5F5)
    }

}
