//
//  Endpoints.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation

enum Endpoints: String {
    case stockHoldingList = "mockbin.io"
}

struct EndpointURL {
    
    static let baseUrl = "https://35dee773a9ec441e9f38d5fc249406ce.api."
    
    /// - Parameter endpoint: <#endpoint description#>
    /// - Returns: <#description#>
    static func getStockHoldingData(endpoint: String) -> URL?{
        let components = URLComponents(string: baseUrl + endpoint)
        return components?.url
    }
}
