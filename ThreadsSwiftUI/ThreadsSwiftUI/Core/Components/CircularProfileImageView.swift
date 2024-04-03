//
//  CircularProfileImageView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct CircularProfileImageView: View {
    var body: some View {
        Image("raikonen")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
