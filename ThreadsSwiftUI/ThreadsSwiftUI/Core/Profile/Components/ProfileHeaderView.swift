//
//  ProfileHeaderView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/19/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User?

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                // fullname and username
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(user?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.username ?? "")
                        .font(.subheadline)
                })
                
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)                                
                }
                
                Text("2 followers")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            CircularProfileImageView(size: .big)
        }
    
    }
}

#Preview {
    ProfileHeaderView(user: DeveloperPreview.user)
}
