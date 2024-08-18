//
//  PlaylistDescriptionCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/18/24.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Product.mock.description
    var userName: String = "Juancho"
    var subheadline: String = "Some headline goes here"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onAPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouSection
            
            Text(subheadline)
            
            buttonsRow
        })
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0, content: {
            HStack(alignment: .center, spacing: 0, content: {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            })
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center, spacing: 8, content: {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .onTapGesture {
                        
                    }
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            })
            .foregroundStyle(.spotifyGreen)
        })
        .font(.title2)

    }
    
    private var madeForYouSection: some View {
        Label(
            title: { 
                Text("Made for ")
                +
                Text(userName)
                    .bold()
                    .foregroundStyle(.spotifyWhite)
            },
            icon: { 
                Image(systemName: "applelogo") 
                    .font(.title3)
                    .foregroundStyle(.spotifyGreen)
            }
        )
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell()
            .padding()
    }
}
