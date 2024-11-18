//
//  HomePageViewModelClass.swift
//  Upstox
//
//  Created by MacBook on 15/11/24.
//

import Foundation

protocol HomePageViewModelInputProtocol: AnyObject {
    func getStockHoldingData()
}

protocol HomePageViewModelOutputProtocol: AnyObject {
    func tableViewReload()
    func failure()
}

protocol HomePageViewModelTypeProtocol: AnyObject {
    var stockHoldingsData: Holdings? { get }
    var input: HomePageViewModelInputProtocol {get}
}

final class HomePageViewModelClass: HomePageViewModelInputProtocol,HomePageViewModelTypeProtocol {
    
    private var stockHolding: Holdings?

    var input: HomePageViewModelInputProtocol {return self}
    
    ///property: holds th data of stocks list fetched from server
    var stockHoldingsData: Holdings? {
        return stockHolding
    }
    
    private(set) weak var delegate: HomePageViewModelOutputProtocol?
    var networkService: StocksHoldingServiceManagerProtocol
    
    init(delegate: HomePageViewModelOutputProtocol ) {
        self.delegate = delegate
        self.networkService = StocksHoldingServiceManager()
    }
    
    /// Used to fetch the data from the remote
    func getStockHoldingData() {
        networkService.fetchHoldingStocks { [weak self] result in
            switch result {
            case .success(let success):
                self?.stockHolding = success
                self?.delegate?.tableViewReload()
            case .failure(let failure):
                self?.delegate?.failure()
            }
        }
        
    }
    
}
