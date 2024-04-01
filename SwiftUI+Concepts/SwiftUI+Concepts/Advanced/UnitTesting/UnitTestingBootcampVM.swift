//
//  UnitTestingBootcampVM.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/30/24.
//

import Foundation
import SwiftUI
import Combine

class UnitTestingBootcampVM: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    var cancellables = Set<AnyCancellable>()
    let dataService: NewDataServiceProtocol
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let item = dataArray.first(where: {$0 == item }) {
            selectedItem = item }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        if let item = dataArray.first(where: {$0 == item }) {
            print("Saved item \(item)")
        } else {
            throw DataError.itemNotFound   
        }
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)

    }
    
    func downloadWithAsyncAwait() async {
        let items = await dataService.downloadItemsWithAsyncAwait()
        dataArray = items
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
}
