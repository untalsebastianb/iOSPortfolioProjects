//
//  CartView.swift
//  ShoppingApp
//
//  Created by Juan Sebastian Bueno on 1/06/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        ScrollView {
            Text("Your cart is empty")
                .navigationTitle("My Cart")
                .padding(.top)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
