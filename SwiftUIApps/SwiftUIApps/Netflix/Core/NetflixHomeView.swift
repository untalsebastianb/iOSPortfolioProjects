//
//  NetflixHomeView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/30/24.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var productsRow: [ProductRow] = []
    var body: some View {
        ZStack(alignment: .top) { 
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical,
                       content: {
                VStack(spacing: 8,
                       content: {
                    
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        NetflixHeroCell(
                            imageName: heroProduct.firstImage,
                            isNetflixFilm: true,
                            title: heroProduct.title,
                            categories: [heroProduct.category.capitalized, heroProduct.brand?.capitalized ?? "Comedy"],
                            onBackgroundPressed: {},
                            onPlayPressed: {},
                            onMyListPressed: {}
                        )
                        .padding(24)                        
                    }
                })
            })
            .scrollIndicators(.hidden)
            
            VStack(alignment: .leading, spacing: 0, content: {
                header
                    .padding(.horizontal, 16)
                
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) { filterPressed in
                        selectedFilter = filterPressed
                    } onXmarkPressed: { 
                        selectedFilter = nil
                    }
                    .padding(.top)
            })
            .background { 
                GeometryReader { proxy in
                    Rectangle()
                        .onAppear(perform: {
                            fullHeaderSize = proxy.size
                        })
                }
                
            }
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        guard productsRow.isEmpty else { return }
        do {
            currentUser = try await DataBaseHelper().getUsers().first
            let products = try await Array(DataBaseHelper().getProducts())
            heroProduct = products.first
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map { $0.brand })
            for brand in allBrands {
//                let products = self.products.filter({ $0.brand == brand })
                rows.append(ProductRow(title: brand?.capitalized ?? "No Brand", products: products))
            }
            productsRow = rows
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
    
    private var header: some View {
        HStack(spacing: 0, content: {
            Text("For You")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16, content: {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            })
            .font(.title2)
        })
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    NetflixHomeView()
}
