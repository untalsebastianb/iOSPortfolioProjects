//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Juan Sebastian Bueno on 1/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()

    var body: some View {
        TabView {
            ShopView()
                .environmentObject(cartManager)
                .badge(cartManager.products.count)
                .tabItem {
                    Label("Shop", systemImage: "cart")
                }

            Text("...")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }

        }
    }
}

struct ShopView: View {
    @EnvironmentObject var cartManager: CartManager
    var column = [GridItem(.adaptive(minimum: 160), spacing: 25)]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column, spacing: 20) {
                    ForEach(productList, id: \.id) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle("Sneakers Shop")
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.products.count)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
