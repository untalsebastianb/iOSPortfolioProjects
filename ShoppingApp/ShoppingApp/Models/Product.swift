//
//  Product.swift
//  ShoppingApp
//
//  Created by Juan Sebastian Bueno on 1/06/23.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Product(name: "Nike travis scott", image: "sneaker1", price: 200),
                   Product(name: "Nike Air Force", image: "sneaker2", price: 100),
                   Product(name: "Nike Air Force Black", image: "sneaker3", price: 99),
                   Product(name: "Kswiss", image: "sneaker4", price: 80),
                   Product(name: "Nike Blunt", image: "sneaker5", price: 89),
                   Product(name: "Adidas classic", image: "sneaker6", price: 94),
                   Product(name: "Nike Running 2.0", image: "sneaker7", price: 98),
                   Product(name: "Converse All Star", image: "sneaker8", price: 66)
]
