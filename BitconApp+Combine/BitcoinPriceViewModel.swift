//
//  BitcoinPriceViewModel.swift
//  BitconApp+Combine
//
//  Created by Sebastian on 10/02/23.
//

import Combine
import Foundation

class BitcoinPriceViewModel: ObservableObject {
    @Published public private(set) var lastUpdated: String = ""
    @Published public private(set) var priceDetails: [PriceDetails] = Currency.allCases.map {
        PriceDetails(currency: $0)
    }
    
    public func onAppear() {
        // get data from the API
    }
}
