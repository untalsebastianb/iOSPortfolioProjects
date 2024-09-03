//
//  ShareButton.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 9/3/24.
//

import SwiftUI

struct ShareButton: View {
    var url: String = "https:www.google.com"
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url, label: {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(.clear)
            })            
        }
            
    }
}

#Preview {
    ZStack { 
        Color.black.ignoresSafeArea()
        ShareButton()
    }
}
