//
//  MockServiceManager.swift
//  Upstox
//
//  Created by MacBook on 18/11/24.
//

import Foundation

final class MockStocksHoldingServiceManager: StocksHoldingServiceManagerProtocol {
    var mockResult: Result<Holdings, NetworkErrors>?

    func fetchHoldingStocks(completion: @escaping (Result<Holdings, NetworkErrors>) -> Void) {
        if let result = mockResult {
            completion(result)
        } else {
            completion(.failure(.decodingFailed)) // Default error
        }
    }
}
