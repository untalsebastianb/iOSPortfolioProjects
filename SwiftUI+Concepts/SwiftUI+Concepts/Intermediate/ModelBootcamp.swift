//
//  ModelBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 7/20/24.
//

import SwiftUI

struct UserModel1: Identifiable {
    var id = UUID().uuidString
    let name: String
    let age: Int
    let followers: Int
    let isVerified: Bool
}


struct ModelBootcamp: View {
    @State var users: [UserModel1] = [
        .init(name: "Emily", age: 24, followers: 200, isVerified: true),
        .init(name: "Laila", age: 34, followers: 132, isVerified: true),
        .init(name: "Sebastian", age: 28, followers: 801, isVerified: false)
    ]
    var body: some View {
        NavigationView(content: {
            List { 
                ForEach(users) { user in
                    HStack(spacing: 15, content: {
                        Circle()
                            .frame(width: 35, height: 35)
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text("\(user.age)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if user.isVerified {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.blue)                            
                        }
                        VStack(content: {
                            Text("\(user.followers)")
                                .font(.headline)
                            Text("Followers")
                                .font(.caption)
                        })
                    })
                    .padding(.vertical, 10)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Users")
        })
    }
}

#Preview {
    ModelBootcamp()
}
