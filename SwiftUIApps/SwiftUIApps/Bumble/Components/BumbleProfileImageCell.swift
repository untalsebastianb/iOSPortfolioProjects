//
//  BumbleProfileImageCell.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/29/24.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var imageName: String = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)
            
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
                .scaleEffect(x: -1, y: 1)
            
            ImageLoaderView(urlString: imageName)
                .clipShape(Circle())
                .padding(5)
                
        }
        .frame(width: 75, height: 75)
        .overlay(alignment: .bottomTrailing, content: { 
            ZStack(content: {
                if hasNewMessage {
                    Circle()
                        .fill(.bumbleWhite)
                    
                    Circle()
                        .fill(.bumbleYellow)
                        .padding(4)
                }
            })
            .frame(width: 25, height: 25)
            .offset(x: 2, y: 2)
        })
    }
}

#Preview {
    VStack {
        BumbleProfileImageCell()
        BumbleProfileImageCell(percentageRemaining: 0.9)
        BumbleProfileImageCell(percentageRemaining: 0.2)
        BumbleProfileImageCell(hasNewMessage: false)
    }
}
