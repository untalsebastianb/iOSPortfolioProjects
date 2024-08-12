//
//  SpotifyRecentCells.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/11/24.
//

import SwiftUI

struct SpotifyRecentCells: View {
    var imageName: String = Constants.randomImage
    var title: String = "some random title"
    
    var body: some View {
        HStack(spacing: 16, content: {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        })
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .background(Color.blue)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifyRecentCells()
                SpotifyRecentCells()
            }
            HStack {
                SpotifyRecentCells()
                SpotifyRecentCells()
            }
        }
    }
}
