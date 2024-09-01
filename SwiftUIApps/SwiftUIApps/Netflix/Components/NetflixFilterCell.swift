//
//  NetflixFilterCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/30/24.
//

import SwiftUI

struct NetflixFilterCell: View {
    var title: String = "Tv Shows"
    var isDropdown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4, content: {
            Text(title)
            
            if isDropdown {
                Image(systemName: "chevron.down")
            }
        })
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack(content: {
                Capsule(style: .circular)
                    .fill(.netflixDarkGray)    
                    .opacity(isSelected ? 1 : 0)
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1.0)
            })
        )
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack { 
        Color.black.ignoresSafeArea()
        VStack {
            NetflixFilterCell()
            NetflixFilterCell(isSelected: true)
            NetflixFilterCell(isDropdown: false)
        }
    }
}
