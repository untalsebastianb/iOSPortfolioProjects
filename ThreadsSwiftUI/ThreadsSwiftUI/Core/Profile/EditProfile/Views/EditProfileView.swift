//
//  EditProfileView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/9/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    // name and profile
                    HStack { 
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            Text("Charles lecler")
                        }
                        
                        Spacer()
                        CircularProfileImageView()
                    }
                    Divider()
                    
                    // bio field
                    VStack(alignment: .leading) { 
                        Text("Bio")
                            .fontWeight(.semibold)
                        TextField("Enter your bio...", text: $bio, axis: .vertical)
                    }
                    
                    Divider()
                    
                    // link field
                    VStack(alignment: .leading) { 
                        Text("Link")
                            .fontWeight(.semibold)
                        TextField("Add link...", text: $bio, axis: .vertical)
                    }
                    
                    Divider()
                    
                    Toggle("Private profile", isOn: $isPrivateProfile)
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                // to apply edges to the box
                .overlay(content: { 
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                })
                .padding()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) { 
                    Button("Cancel") { 
                        
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing) { 
                    Button("Done") { 
                        
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
            })
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}
