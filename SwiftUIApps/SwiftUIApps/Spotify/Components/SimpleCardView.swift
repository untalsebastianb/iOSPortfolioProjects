//
//  SimpleCardView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/11/24.
//

import SwiftUI

struct SimpleCardView: View {
    var imageName: String = Constants.randomImage
    var imageSize: CGFloat = 100
    var title: String = "Some item name "
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .lineLimit(2)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .padding(4)
        })
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SimpleCardView()        
    }
}
