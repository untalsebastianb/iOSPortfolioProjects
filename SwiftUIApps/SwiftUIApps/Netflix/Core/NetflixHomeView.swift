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
    @State private var scrollViewOffset: CGFloat = 0 

    var body: some View {
        ZStack(alignment: .top) { 
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            
            scrollViewHeader
                        
            fullHeaderWithFilter
            
        }
        .task {
            await getData()
        }
    }
    
    private var backgroundGradientLayer: some View {
        ZStack { 
            LinearGradient(colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0),], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [.netflixDarRed.opacity(0.5), .netflixDarRed.opacity(0),], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffset * 0.75)))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var scrollViewHeader: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false,
            content: {
                VStack(spacing: 8,
                       content: {
                    
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCell(heroProduct: heroProduct)
                            .padding(24)
                    }
                    
                    categoryRows
                    
                })
            },
            onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            })

    }
    
    private var fullHeaderWithFilter: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {
                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter) { filterPressed in
                        selectedFilter = filterPressed
                    } onXmarkPressed: { 
                        selectedFilter = nil
                    }
                    .padding(.top)       
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        })
        .padding(.bottom, 8)
        .background(
            ZStack(content: { 
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(.clear)
                        .ignoresSafeArea()
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                }
            })
        )
        .animation(.smooth, value: scrollViewOffset)
        .background { 
            GeometryReader { proxy in
                Rectangle()
                    .fill(.clear)
                    .onAppear(perform: {
                        fullHeaderSize = proxy.size
                    })
            }
            
        }
    }

    private var categoryRows: some View {
        LazyVStack(spacing: 16,
                   content: {
            ForEach(Array(productsRow.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading,
                       spacing: 6,
                       content: {
                    Text(row.title)
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    ScrollView(.horizontal,
                               content: {
                        LazyHStack(content: {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? index + 1 : nil
                                )
                            }
                        })
                        .padding(.horizontal, 16)
                    })
                    .scrollIndicators(.hidden)
                })
            }
        })
        .foregroundStyle(.netflixWhite)

    }
    
    private func heroCell(heroProduct: Product) -> some View {
        NetflixHeroCell(
            imageName: heroProduct.firstImage,
            isNetflixFilm: true,
            title: heroProduct.title,
            categories: [heroProduct.category.capitalized, heroProduct.brand?.capitalized ?? "Comedy"],
            onBackgroundPressed: {},
            onPlayPressed: {},
            onMyListPressed: {}
        )
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
                rows.append(ProductRow(title: brand?.capitalized ?? "No Brand", products: products.shuffled()))
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
