//
//  HoldingsModel.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation

struct Holdings: Codable {
    let data: DataClass?

   /// 1. Current value = sum of (Last traded price * quantity of holding ) of all the holdings
    var currentValue: Double {
        data?.userHolding?.reduce(0) { $0 + (($1.ltp) * Double($1.quantity)) }.rounded(to: 2) ?? 0
    }
    
    ///2. Total investment = sum of (Average Price * quantity of holding ) of all the holdings
    var totalInvestment: Double {
        data?.userHolding?.reduce(0) { $0 + (($1.avgPrice) * Double($1.quantity)) }.rounded(to: 2) ?? 0
    }
    
    ///3. Total PNL = Current value - Total Investment
    var totalPNL: Double {
        (currentValue - totalInvestment).rounded(to: 2)
    }
    
    var totalPNLPercentage: Double {
        ((totalPNL / totalInvestment) * 100).rounded(to: 2)
    }
    
    ///4. Today’s PNL = sum of ((Close - LTP ) * quantity) of all the holdings
    var todayPNL: Double {
        data?.userHolding?.reduce(0) { $0 + ((($1.close) - ($1.ltp)) * Double($1.quantity)) }.rounded(to: 2) ?? 0
    }
        
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct DataClass: Codable {
    let userHolding: [UserHolding]?
    
    enum CodingKeys: String, CodingKey {
        case userHolding = "userHolding"
    }
}

struct UserHolding: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case quantity = "quantity"
        case ltp = "ltp"
        case avgPrice = "avgPrice"
        case close = "close"
    }
}
