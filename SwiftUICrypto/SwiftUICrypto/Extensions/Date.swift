//
//  Date.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 12/4/23.
//

import Foundation

extension Date {
    init(coinString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormmater: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormmater.string(from: self)
    }
}
