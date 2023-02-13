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
    
    private var subscription: AnyCancellable?
    
    public func onAppear() {
        // get data from the API
        subscription = CoindeskAPIService.shared.fetchBitcoinPrice()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.lastUpdated = value.time.updated
                self.priceDetails = [
                    PriceDetails(currency: .usd, rate: value.bpi.USD.rate),
                    PriceDetails(currency: .eur, rate: value.bpi.EUR.rate),
                    PriceDetails(currency: .gbp, rate: value.bpi.GBP.rate),
                ]
            })
        
    }
}
