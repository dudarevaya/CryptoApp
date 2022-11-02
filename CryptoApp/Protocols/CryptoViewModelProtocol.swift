//
//  CryptoViewModelProtocol.swift
//  CryptoApp
//
//  Created by Яна Дударева on 21.10.2022.
//

import Foundation

protocol CryptoViewModelProtocol {
    var name: String { get }
    var symbol: String { get }
    var priceUsd: Double { get }
    var persentChangeUsdLast24Hours: Double { get }
    var id: String { get }
}
