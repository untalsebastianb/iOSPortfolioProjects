//
//  BumbleChatPreviewCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/29/24.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var userName: String = "Juancho"
    var lastChatMessage: String? = "This is the last message"
    var isYourMove: Bool = true
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) { 
            BumbleProfileImageCell(
                imageName: imageName,
                percentageRemaining: percentageRemaining,
                hasNewMessage: hasNewMessage
            )
            
            VStack(alignment: .leading, spacing: 2, content: {
                HStack(spacing: 0,content: {
                    Text(userName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if isYourMove {
                        Text("Your Move")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(.bumbleYellow)
                            .cornerRadius(32)
                    }
                })
                
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .padding(.trailing, 16)
                }
            })
            .lineLimit(1)
        }
    }
}

#Preview {
    BumbleChatPreviewCell()
        .padding()
}
