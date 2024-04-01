//
//  DataService.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/31/24.
//

import Foundation
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> 
    func downloadItemsWithAsyncAwait() async -> [String]
}

class NewMockDataService: NewDataServiceProtocol {
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "One", "two", "three"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadItemsWithAsyncAwait() async -> [String] {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        let newItems = ["one", "two"]
        return newItems
    }
}
