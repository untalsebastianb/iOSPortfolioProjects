//
//  SpotifySongRowCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/19/24.
//

import SwiftUI

struct SpotifySongRowCell: View {
    var imgeSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "some song name goes here"
    var subtitle: String? = "some subtitle goes here"
    var onCellPressed: (() -> Void)? = nil 
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8, content: {
            ImageLoaderView(urlString: imageName)
                .frame(width: imgeSize, height: imgeSize)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)
                }
            })
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.spotifyWhite)
            
            Image(systemName: "ellipsis")
                .foregroundStyle(.spotifyWhite)
                .font(.subheadline)
                .padding(16)
                .background(content: { 
                    Color.black.opacity(0.001)
                })
                .onTapGesture {
                    onEllipsisPressed?()
                }
        })
        .onTapGesture {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()
        VStack {
            SpotifySongRowCell()      
            SpotifySongRowCell()    
            SpotifySongRowCell()    
            SpotifySongRowCell()    
            SpotifySongRowCell()    
            SpotifySongRowCell()    
        }
        
    })
}
