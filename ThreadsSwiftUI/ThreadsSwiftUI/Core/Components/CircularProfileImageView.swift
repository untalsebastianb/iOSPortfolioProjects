//
//  CircularProfileImageView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI
import Kingfisher

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
    var user: User?
    private let size: Size
    
    init(user: User?, size: Size = .regular) {
        self.user = user
        self.size = size
    }

    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.widht, height: size.height)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.widht, height: size.height)
                .foregroundColor(Color(.systemGray4))
        }
    }
    
    init(size: Size = .regular) {
        self.size = size
    }
}

#Preview {
    CircularProfileImageView()
}
