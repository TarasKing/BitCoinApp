//
//  CoinData.swift
//  BitCoinApp
//
//  Created by Taras on 07/03/2023.
//

import Foundation


// Codable is used when Decodable and Encodable

struct CoinData: Codable {
    let rate: Double
    let currencyID: String
    let bitcoinID: String
    let Time: String
}
