//
//  EditProfileView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/9/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    @StateObject var viewModel = EditProfileViewModel()

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
                            Text(user.fullname)
                        }
                        
                        Spacer()
                        PhotosPicker(selection: $viewModel.selectedItem) { 
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileImageView(user: user)
                            }
                        }
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
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing) { 
                    Button("Done") { 
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
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
        EditProfileView(user: DeveloperPreview.user)
    }
}
