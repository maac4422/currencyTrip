//
//  converterWorker.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/2/19.
//  Copyright (c) 2019 Guillermo Costa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

protocol IConverterWorker {
//    var countryFlagsApi: ICountryFlagsAPI? { get }
    var currencyTripApi: ICurrencyTripAPI? { get }
    
    func fetchCurrencies(completion: @escaping (Currency.Fetch.State) -> ())
}

class ConverterWorker: IConverterWorker {
    var currencyTripApi: ICurrencyTripAPI?
//    var countryFlagsApi: ICountryFlagsAPI?
    
    init() {
        currencyTripApi = CurrencyTripAPI()
    }
  
    func fetchCurrencies(completion: @escaping (Currency.Fetch.State) -> ()) {
        currencyTripApi?.fetchCurrencies() { (result: Currency.Fetch.State) in
            switch result {
            case .success(response: let response):
                print(response)
                completion(.success(response: response))
            case .error(error: let message):
                print(result)
                completion(.error(message))
            }
        }
    }
}
