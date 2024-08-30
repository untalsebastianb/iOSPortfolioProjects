//
//  InterestPillView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/28/24.
//

import SwiftUI

struct InterestPillView: View {
    var iconName: String? = "heart.fill"
    var emoji: String? = "🔥"
    var text: String = "Graduate Degree"
    var body: some View {
        HStack(spacing: 4, content: {
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }
            
            Text(text)
        })
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightYellow)
        .cornerRadius(32)
    }
}

#Preview {
    VStack {
        InterestPillView(iconName: nil)
        InterestPillView(emoji: nil)
    }
}
