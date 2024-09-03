//
//  NetflixDetailsHeaderView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 9/2/24.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsHeaderView: View {
    var imageName: String = Constants.randomImage
    @State var progress: Double = 0.2
    var onAirPlayPressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var body: some View {
        ZStack(alignment: .bottom) { 
            ImageLoaderView(urlString: imageName)
            CustomProgressBar(
                selection: progress,
                range: 0...1,
                backgroundColor: .netflixLightGray,
                foregroundColor: .netflixRed,
                cornerRadius: 2,
                height: 4
            )
            .padding(.vertical, 4)
            .animation(.linear, value: progress)
            
            HStack(content: {
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay(content: { 
                        Image(systemName: "tv.badge.wifi")
                            .offset(y: 1)
                    })
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        onAirPlayPressed?()
                    }
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay(content: { 
                        Image(systemName: "xmark")
                            .offset(y: 1)
                    })
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        onXMarkPressed?()
                    }
            })
            .foregroundStyle(.netflixWhite)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

#Preview {
    NetflixDetailsHeaderView()
}
