//
//  ContentView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(products) { product in
                    Text(product.category)
                }
            }
        }
        .padding()
        .task {
            await getData()
        }
    }
    private func getData() async {
        do {
            users = try await DataBaseHelper().getUsers()
            products = try await DataBaseHelper().getProducts()
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
