//
//  CurrencyTripApi.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/2/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import Foundation

protocol ICurrencyTripAPI {
    
    func fetchCurrencies(completion: @escaping (Currency.Fetch.State) -> ())
}

// https://github.com/typicode/json-server
// json-server --watch db.json
class CurrencyTripAPI: ICurrencyTripAPI {
    
    func fetchCurrencies(completion: @escaping (Currency.Fetch.State) -> ()) {
        let allCurrencies = "http://localhost:3000/currencies"
        let specificCurrency = "http://localhost:3000/currencies/\(2)"
        let currenciesByCodes = "http://localhost:3000/currencies?code=EUR&code=USD"
        let orderCurrencies = "http://localhost:3000/currencies?_sort=code&_order=desc"
        let orderCurrenciesASc = "http://localhost:3000/currencies?_sort=code&_order=asc"
    }
    
}
