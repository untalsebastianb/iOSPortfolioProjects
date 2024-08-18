//
//  SoitifyPlaylistView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/18/24.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    var product: Product = .mock
    var user: User = .mock
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
                })
            }
            .scrollIndicators(.hidden)
        })
    }
}

#Preview {
    SpotifyPlaylistView()
}
