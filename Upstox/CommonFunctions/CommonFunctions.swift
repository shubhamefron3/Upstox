//
//  CommonFunctions.swift
//  Upstox
//
//  Created by MacBook on 17/11/24.
//

import Foundation
import UIKit

struct Utilities {
    ///  1. Current value = sum of (Last traded price * quantity of holding ) of all the holdings
    ///  2. Total investment = sum of (Average Price * quantity of holding ) of all the holdings
    ///  3. Total PNL = Current value - Total Investment
    static func calulateProfitNLoss(model: UserHolding?) -> Double {
        let currentValue = ((model?.ltp ?? 0) * Double(model?.quantity ?? 0))
        let totalInvestment = ((model?.avgPrice ?? 0 ) * Double(model?.quantity ?? 0))
        let totalPNL = (currentValue - totalInvestment).rounded(to: 2)
        return totalPNL
    }
    
    ///as per P&L, if P = Green and L = Red
    static func setupTextColor(textValue:Double?) -> UIColor {
        if textValue ?? 0 < 0 {
            return UIColor.red
        } else {
            return UIColor.forestGreen
        }
    }
}
