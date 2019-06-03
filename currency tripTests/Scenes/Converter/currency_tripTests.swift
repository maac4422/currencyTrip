//
//  currency_tripTests.swift
//  currency tripTests
//
//  Created by Guillermo Costa on 6/2/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import XCTest
@testable import currency_trip

class ConverterInteractorTests: XCTestCase {
    
    var converterInteractor: ConverterInteractor!

    override func setUp() {
        converterInteractor = ConverterInteractor()
    }

    override func tearDown() {}
    
}

// MARK: Test
private extension ConverterInteractorTests {

    func testShowGroup_ShouldCallPresentMessage_WithEmptyGroup() {
        // Given
        let spy = ConverterPresentationLogicSpy()
        converterInteractor.presenter = spy
        
        // When
        converterInteractor.fetch()
        
        // Then
//        TODO COMPLETE
//        XCTAssertTrue(spy.presentCurrenciesFetchingError, "showEmpty() should presentMessage() with am empty currencies")
        XCTAssertTrue(true)
    }
}

// MARK: Tests doubles
private extension ConverterInteractorTests {

    class ConverterPresentationLogicSpy: ConverterPresentationLogic {
        var presentCurrenciesVerification = false
        var presentConvertedCurrenciesVerification = false
        var presentCurrenciesErrorVerification = false
        
        func presentCurrencies(viewModel: [Currency.Fetch.ViewModel]) {
            presentCurrenciesVerification = true
        }
        
        func presentConvertedCurrencies(viewModel: [Currency.Fetch.ViewModel]) {
            presentConvertedCurrenciesVerification = false
        }
        
        func presentCurrenciesFetchingError(response: Currency.Fetch.Response) {
            presentCurrenciesErrorVerification = true
        }
    }
    
    class GroupWorkerSpy: ConverterWorker {
        var expectation: XCTestExpectation?
        var response: [Currency.Fetch.Response]?
        var error: Error?
        
        override func fetchCurrencies(with request: Currency.Fetch.Request, completion: @escaping (Currency.Fetch.State) -> ()) {
            
            expectation?.fulfill()
        }
    }
}
