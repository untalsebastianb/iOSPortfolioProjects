//
//  PlaylistHeaderCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/18/24.
//

import SwiftUI

struct PlaylistHeaderCell: View {
    var height: CGFloat = 300
    var title: String = "Some Playlist title goes here"
    var subtitle: String = "Subtitle"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay { 
                ImageLoaderView(urlString: imageName)
            }
            .overlay(alignment: .bottomLeading,
                     content: {
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(subtitle)
                        .font(.headline)
                    
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                })
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    LinearGradient(
                        colors: [
                            shadowColor.opacity(
                                0
                            ),
                            shadowColor
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )   
                )
            })
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ScrollView { 
            PlaylistHeaderCell() 
        }
    }
    .ignoresSafeArea()
}
