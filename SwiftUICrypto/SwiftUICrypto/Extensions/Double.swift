//
//  Double.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 10/16/23.
//

import Foundation

extension Double {
    
    /// converts a double into a Currency with 2 decimal places
    /// ```
    /// Convert 123.56 to $1,234.56

    /// ``
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// converts a double into a Currency as String with 2 decimal places
    /// ```
    /// Convert 123.56 to "$1,234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// converts a double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 123.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// ``
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// converts a double into a Currency as String with 2-6 decimal places
    /// ```
    /// Convert 123.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// converts a double into a String representation 
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// converts a double into a String representation with percent symbol
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
