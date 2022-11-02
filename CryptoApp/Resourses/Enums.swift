//
//  Constants.swift
//  CryptoApp
//
//  Created by Яна Дударева on 08.10.2022.
//

import Foundation

enum UserDefaultsKeys {
    static let isLogged = "isLogged"
    static let sortAscending = "priceAscending"
    static let sortDescending = "priceDescending"
}

enum StrCrypto {
    static let cryptoSymbols: [String] = [
    "btc", "eth", "tron", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp", "bnb", "busd"
    ]
}

enum Sorting {
    case priceAscending
    case priceDescending
}

