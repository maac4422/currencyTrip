//
//  Currency.swift
//  currencyWatch Extension
//
//  Created by Miguel Angel Arenas Correa on 6/3/19.
//  Copyright © 2019 Guillermo Costa. All rights reserved.
//

struct Currency: Codable {
    var id: Int
    var code: String
    var image: String?
    var name: String
    var value: Float
    var convertedValue: Float?
    
    mutating func convertValue(with value: Float) {
        convertedValue = value
    }
}
