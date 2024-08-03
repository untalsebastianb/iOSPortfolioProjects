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
struct Product: Codable, Identifiable {
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
}
