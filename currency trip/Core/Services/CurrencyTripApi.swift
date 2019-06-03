//
//  CurrencyTripApi.swift
//  currency trip
//
//  Created by Guillermo Costa on 6/2/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

import Foundation

protocol ICurrencyTripAPI {
    var baseHost: String { get }
    var baseMethod: String { get }
    var basePort: Int { get }
    var baseScheme: String { get }
    var baseUrl: String { get }
    
    func fetchCurrencies(completion: @escaping (Currency.Fetch.State) -> ())
}

// https://github.com/typicode/json-server
// allCurrencies = "http://localhost:3000/currencies"
// specificCurrency = "http://localhost:3000/currencies/\(2)"
// currenciesByCodes = "http://localhost:3000/currencies?code=EUR&code=USD"
// orderCurrencies = "http://localhost:3000/currencies?_sort=code&_order=desc"
// orderCurrenciesASc = "http://localhost:3000/currencies?_sort=code&_order=asc"
// json-server --watch db.json
class CurrencyTripAPI: ICurrencyTripAPI {
    private (set) var baseHost = "localhost"
    private (set) var baseMethod = "GET"
    private (set) var basePort = 3000
    private (set) var baseScheme = "http"
    private (set) var baseUrl = "currencies"
    
    func fetchCurrencies(completion: @escaping (Currency.Fetch.State) -> ()) {

        var components = URLComponents()
        components.scheme = baseScheme
        components.host = baseHost
        components.path = baseUrl
        components.port = basePort
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = baseMethod
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.error("ErrorData".localizedCapitalized))
                print(error?.localizedDescription ?? "Unknowed error")
                return
            }
            guard response != nil else { return }
            guard let data = data else { return }
            
            let responseObject = try! JSONDecoder().decode([Currency.Fetch.Response].self, from: data)
            DispatchQueue.main.async {
                let currencies = responseObject.map { Currency.Fetch.ViewModel(with: $0) }
                completion(.success(response: currencies))
            }
        }
        dataTask.resume()
    }
    
}
