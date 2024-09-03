//
//  Product.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title, description, category: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand, sku: String?
    let weight: Int
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let thumbnail: String
    let images: [String]

    var firstImage : String {
        images.first ?? Constants.randomImage
    }
    
    let recentlyAdded: Bool = {
        return Bool.random() 
    }()
    
    static var mock: Product {
        .init(
            id: 123,
            title: "Example product title",
            description: "this is some mock product description",
            category: "Tech",
            price: 198.0,
            discountPercentage: 10,
            rating: 2,
            stock: 10,
            brand: "apple",
            sku: "1122",
            weight: 2,
            returnPolicy: "none",
            minimumOrderQuantity: 1,
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage, Constants.randomImage]
        )
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}

