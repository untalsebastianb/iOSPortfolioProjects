//
//  SpotifyCategoryCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/8/24.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var title: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
            .cornerRadius(16)
    }
}

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 40) { 
            SpotifyCategoryCell(title: "Reggaeton", isSelected: true)
            SpotifyCategoryCell(title: "Pop")
            SpotifyCategoryCell(title: "Jazz", isSelected: true)
            SpotifyCategoryCell(isSelected: true)
        }
    }
}
