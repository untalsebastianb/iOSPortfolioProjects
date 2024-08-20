//
//  SoitifyPlaylistView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/18/24.
//

import SwiftUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    @Environment(\.router) var router
    var product: Product = .mock
    var user: User = .mock
    @State private var products: [Product] = []
    @State private var showHeader = true
    @State private var offset: CGFloat = 0

    var body: some View {
        ZStack(content: {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView { 
                LazyVStack(spacing: 20,
                           content: {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "",
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150 
                    }
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onSharePressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onAPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SpotifySongRowCell(
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: nil
                        )
                        .padding(.leading)
                    }
                })
            }
            .scrollIndicators(.hidden)
            
            ZStack {
                Text(product.title)
                    .font(.headline)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(.spotifyBlack)
                    .offset(y: showHeader ? 0 : -40)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(showHeader ? Color.black.opacity(0.001) : .spotifyGray.opacity(0.7))
                    .clipShape(.circle)
                    .onTapGesture {
                        router.dismissScreen()
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .animation(.smooth(duration: 0.2), value: showHeader)
            .foregroundStyle(.spotifyWhite)
            .frame(maxHeight: .infinity, alignment: .top)
            
        })
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            products = try await Array(DataBaseHelper().getProducts().prefix(upTo: 20))
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyPlaylistView()
    }
}
