//
//  SpotifyNewReleaseCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/11/24.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New Release From"
    var subheadline: String? = "some artist"
    var title: String? = "Some playlist"
    var subtitle: String? = "Single - Title"
    var onAddToPlayListPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16, content: {
            HStack(spacing: 8, content: {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2, content: {
                    if let headline {
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    
                    if let subheadline {
                        Text(subheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                    }
                })
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                
                
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 2) {
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.spotifyLightGray)
                        }
                    }
                    .font(.callout)
                    
                    
                    HStack(spacing: 0) {
                        /** if we want to convert anything into a button is a good idea to have
                         some background layer on it, so I add padding before background to make
                         tapable area bigger, the substract the padding value with offset to make
                         aligned 
                         .offset(x: -4)
                         .background(.black.opacity(0.001)) to make it render and tappable
                         
                         
                         Note: to debugUI place background/borders before padding
                        **/
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title3)
                            .padding(4)
                            .background(.black.opacity(0.001))
                            .onTapGesture {
                                onAddToPlayListPressed?()
                            }
                            .offset(x: -4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
                    }
                }
                .padding(.vertical, 16)
                .padding(.trailing, 16)

            }
            .themeColors(isSelected: false)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
        })
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SpotifyNewReleaseCell()       
            .padding()
    }
}
