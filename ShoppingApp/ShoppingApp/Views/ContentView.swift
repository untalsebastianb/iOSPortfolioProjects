//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Juan Sebastian Bueno on 1/06/23.
//

import SwiftUI

struct ContentView: View {
    var column = [GridItem(.adaptive(minimum: 160), spacing: 25)]

    var body: some View {

        NavigationView {
            ScrollView {
                LazyVGrid(columns: column, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
                    }
                }
                .padding()
            }
            .navigationTitle("Sneakers Shop")
            .toolbar {
                CartButton(numberOfProducts: 1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
