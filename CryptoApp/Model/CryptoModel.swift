//
//  CryptoModel.swift
//  CryptoApp
//
//  Created by Яна Дударева on 08.10.2022.
//

import Foundation

struct CryptoData: Decodable {
    let data: DataClass
}

struct DataClass: Decodable {
    
    var id, symbol, name: String
    var marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case marketData = "market_data"
    }
}

struct MarketData: Decodable {
    let priceUsd, persentChangeUsdLast24Hours: Double

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case persentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
    }
}
