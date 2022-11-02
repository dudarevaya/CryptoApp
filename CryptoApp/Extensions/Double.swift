//
//  Double.swift
//  CryptoApp
//
//  Created by Яна Дударева on 14.10.2022.
//

import Foundation

extension Double {
    
    func toStringWith(currency: String) -> String {
        if currency == "$" {
            let formatter = NumberFormatter()
            formatter.currencySymbol = "$"
            formatter.numberStyle = .currency
            formatter.usesGroupingSeparator = true
            formatter.locale = NSLocale.current
            return formatter.string(from: self as NSNumber) ?? ""
        } else if currency == "%" {
            let formatter = NumberFormatter()
            formatter.currencySymbol = "%"
            formatter.usesGroupingSeparator = true
            formatter.locale = NSLocale.current
            formatter.numberStyle = .currency
            formatter.negativePrefix = formatter.minusSign
            formatter.positivePrefix = formatter.plusSign
            let result = "\(formatter.string(from: self as NSNumber) ?? "")\(formatter.currencySymbol ?? "%")"
            return result
        }
        return ""
    }
    
}
