//
//  SpotifyHomeView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/8/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

final class SpotifyHomeViewModel: ObservableObject {
    let router: AnyRouter
    @Published private var currentUser: User? = nil
    @Published private var selectedCategory: Category? = nil
    @Published private var products: [Product] = []
    @Published private var productsRow: [ProductRow] = []
    
    init(router: AnyRouter) {
        self.router = router
    }
}

struct SpotifyHomeView: View {
    @Environment(\.router) var router 
    @StateObject var viewModel: SpotifyHomeViewModel
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productsRow: [ProductRow] = []
    var body: some View {
        ZStack { 
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) { 
                LazyVStack(pinnedViews: [.sectionHeaders],
                           content: {
                    Section {
                        VStack(spacing: 16) {
                            recentSection
                                .padding(.horizontal, 16)
                            if let product = products.first {
                                newReleaseSection(product: product)     
                                    .padding(.horizontal, 16)
                            }
                            listRows
                        }
                    } header: { 
                        header
                    }

                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
            .task {
                await getData()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var listRows: some View {
        ForEach(productsRow) { row in
            VStack(spacing: 8,
                   content: {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                /**
                 To make the scroll view go to the edge of the device, the padding 
                 is now on the HStack inside Scroll View
                 */
                ScrollView(.horizontal) { 
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            SimpleCardView(
                                imageName: product.firstImage,
                                imageSize: 120,
                                title: product.title
                            )
                            .asButton(.press, action: {
                                goToPlaylistView(product: product)
                            })
                        }
                    }
                    .padding(.horizontal, 16)
                }
            })
        }
    }
    
    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlayListPressed: nil,
            onPlayPressed: {
                goToPlaylistView(product: product)
            }
        ) 
    }
    
    private var recentSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentCells(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press, action: {
                    goToPlaylistView(product: product)
                })
            }
        }
    }
    
    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            // tip keep the frame on the view hierarchy
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            router.dismissScreen()
                        }                    
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal, showsIndicators: false) { 
                HStack(spacing: 8, content: {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                })
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifyBlack)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DataBaseHelper().getUsers().first
            products = try await Array(DataBaseHelper().getProducts().prefix(upTo: 20))
            
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
}

#Preview {
    RouterView { router in
        SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
    }
}
