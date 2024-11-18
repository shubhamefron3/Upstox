//
//  ExtensionFunctions.swift
//  Upstox
//
//  Created by MacBook on 17/11/24.
//

import Foundation
import UIKit

extension Double {
    ///using to round of doubke upto 2 digits
    func rounded(to places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}

extension UIColor {
    static let red = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0) // Standard Red
    static let forestGreen = UIColor(red: 0.13, green: 0.55, blue: 0.13, alpha: 1.0) // Forest Green
}

extension UIView {
    ///to round top left and right corners of  P&L List 
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
