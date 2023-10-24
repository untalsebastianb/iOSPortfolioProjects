//
//  CoinImageViewModel.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 10/20/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let dataService: CoinImageService
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.dataService = CoinImageService(coin: coin)
        self.coin = coin
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self ]_ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
