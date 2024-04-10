//
//  CircularProfileImageView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

enum Size {
    case small
    case regular
    case big
    
    var widht: CGFloat {
        switch self {
        case .small: 20
        case .regular: 40
        case .big: 60
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: 20
        case .regular: 40
        case .big: 60
        }
    }
}

struct CircularProfileImageView: View {
    private let size: Size
    var body: some View {
        Image("raikonen")
            .resizable()
            .scaledToFill()
            .frame(width: size.widht, height: size.height)
            .clipShape(Circle())
    }
    
    init(size: Size = .regular) {
        self.size = size
    }
}

#Preview {
    CircularProfileImageView()
}
