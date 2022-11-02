//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Яна Дударева on 19.10.2022.
//

import Foundation

extension CryptoData: CryptoViewModelProtocol {
    
    var id: String {
        return data.id
    }
    
    var name: String {
        return data.name
    }
    
    var symbol: String {
        data.symbol
    }
    
    var priceUsd: Double {
        data.marketData.priceUsd
    }
    
    var persentChangeUsdLast24Hours: Double {
        data.marketData.persentChangeUsdLast24Hours
    }
}
