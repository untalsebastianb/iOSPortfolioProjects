//
//  UserCell.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct UserCell: View {
    let user: User
    var body: some View {
        HStack {
            CircularProfileImageView(user: user)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                Text(user.fullname)
            }
            .font(.footnote)
            
            Spacer()
            Text("Follow")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay { 
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell(user: DeveloperPreview.user)
}
