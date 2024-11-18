//
//  UpstoxTests.swift
//  UpstoxTests
//
//  Created by MacBook on 18/11/24.
//

import XCTest
@testable import Upstox

final class MockHomePageViewModelOutputDelegate: HomePageViewModelOutputProtocol {
    var isTableViewReloadCalled = false

    func tableViewReload() {
        isTableViewReloadCalled = true
    }
}

final class UpstoxTests: XCTestCase {

    var viewModel: HomePageViewModelClass!
    var mockDelegate: MockHomePageViewModelOutputDelegate!
    var mockServiceManager: MockStocksHoldingServiceManager!

    override func setUp() {
        super.setUp()
        mockServiceManager = MockStocksHoldingServiceManager()
        mockDelegate = MockHomePageViewModelOutputDelegate()
        viewModel = HomePageViewModelClass(delegate: mockDelegate)
        viewModel.networkService = mockServiceManager
    }

    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        mockServiceManager = nil
        super.tearDown()
    }

    
    func testFetchStockHoldingsData_Success() {
        
        let mockUserHolding = UserHolding(symbol: "ICICI", quantity: 10, ltp: 150.0, avgPrice: 140.0, close: 145.0)
        let mockDataClass = DataClass(userHolding: [mockUserHolding])
        let mockHoldings = Holdings(data: mockDataClass)
        mockServiceManager.mockResult = .success(mockHoldings)
        
        viewModel.getStockHoldingData()
       
        XCTAssertNotNil(viewModel.stockHoldingsData, "StockHoldingsData should not be nil")
        XCTAssertNotNil(viewModel.stockHoldingsData?.data?.userHolding?.count,"There should be holdings")
        XCTAssertEqual(viewModel.stockHoldingsData?.data?.userHolding?.first?.symbol, "ICICI", "Symbol should match")
        XCTAssertEqual(viewModel.stockHoldingsData?.data?.userHolding?.first?.close, 145.0, "close Value should match")
        XCTAssertTrue(mockDelegate.isTableViewReloadCalled, "Delegate's tableViewReload should be called on success")
    }


    func testFetchStockHoldingsData_Failure() {
       
        let mockError = NetworkErrors.serverError
        mockServiceManager.mockResult = .failure(.decodingFailed)
        
        
        viewModel.getStockHoldingData()

       
        XCTAssertNil(viewModel.stockHoldingsData, "StockHoldingsData should be nil on failure")
        XCTAssertFalse(mockDelegate.isTableViewReloadCalled, "Delegate's tableViewReload should not be called on failure")
    }
    
    func test_utilities(){
        let mockUserHolding = UserHolding(symbol: "ICICI", quantity: 10, ltp: 150.0, avgPrice: 140.0, close: 145.0)
        XCTAssertNotNil(Holdings(data: DataClass(userHolding: [mockUserHolding])))
        XCTAssertNotNil(Utilities.calulateProfitNLoss(model: mockUserHolding))
        XCTAssertNotNil(Utilities.setupTextColor(textValue: 100))
    }
}

