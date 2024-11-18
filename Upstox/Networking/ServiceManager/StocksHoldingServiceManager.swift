//
//  StocksHoldingServiceManager.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation


protocol StocksHoldingServiceManagerProtocol: AnyObject {
    /// fetching stocks holding data from api
    /// - Parameter completion: Holdings data model in success, network error for failure
    func fetchHoldingStocks(completion: @escaping (Result<Holdings,NetworkErrors>) -> Void)
}

final class StocksHoldingServiceManager: StocksHoldingServiceManagerProtocol {
    
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func fetchHoldingStocks(completion: @escaping (Result<Holdings, NetworkErrors>) -> Void) {
        let endpoint = EndpointURL.getStockHoldingData(endpoint: Endpoints.stockHoldingList.rawValue)
        
        if let urlEndpoint = endpoint {
            apiClient.fetchGetRequest(endpoint: urlEndpoint, completionHandler: completion)
        }
    }
}
