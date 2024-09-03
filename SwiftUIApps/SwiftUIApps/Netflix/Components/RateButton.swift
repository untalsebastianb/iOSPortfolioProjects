//
//  RateButton.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 9/3/24.
//

import SwiftUI

enum RateOption: String, CaseIterable {
    case dislike
    case like
    case love
    
    var title: String {
        switch self {
        case .dislike:
            "Not for me"
        case .like:
            "I like this"
        case .love:
            "Love this!"
        }
    }
    
    var iconName: String {
        switch self {
        case .dislike:
            "hand.thumbsdown"
        case .like:
            "hand.thumbsup"
        case .love:
            "bolt.heart"
        }
    }
}

struct RateButton: View {
    @State private var showPopOver: Bool = false
    var onOptionTapped: ((RateOption) -> Void)? = nil
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.thumbsup")
                .font(.title)

            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.clear)
        .onTapGesture {
            showPopOver.toggle()
        }
        .popover(isPresented: $showPopOver, content: {
            ZStack(content: {
                Color.netflixDarkGray.ignoresSafeArea()
                HStack(spacing: 12, content: {
                    ForEach(RateOption.allCases, id: \.self) { option in
                        rateButton(option: option)
                    }
                })
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            })
            .presentationCompactAdaptation(.popover)
        })
    }
    
    private func rateButton(option: RateOption) -> some View {
        VStack(spacing: 8, content: {
            Image(systemName: option.iconName)
                .font(.title2)
            Text(option.title)
                .font(.caption)
        })
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(.clear)
        .onTapGesture {
            showPopOver = false
            onOptionTapped?(option)
        }
    }
}

#Preview {
    ZStack(content: {
        Color.black.ignoresSafeArea()    
        RateButton()
    })
}
