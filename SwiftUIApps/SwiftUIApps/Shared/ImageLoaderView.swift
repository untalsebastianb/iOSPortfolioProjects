//
//  ImageLoaderView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    // when doing let on the struct I need to create a init, var will give me imply init
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill

    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(content: {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)                
            })
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .clipShape(.rect(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
