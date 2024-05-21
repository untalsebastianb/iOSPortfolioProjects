//
//  CurrentUserProfile.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/14/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @State private var showEditProfile = false
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    private var currentUser: User? {
        return viewModel.currentUser
    }
    private var filterBarWidht: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) { 
                // bio and stats
                VStack(spacing: 20) {
                        ProfileHeaderView(user: currentUser)                        
                    Button { 
                        showEditProfile.toggle()
                    } label: { 
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay { 
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    
                    //user content list view
                    if let user = currentUser {
                        UserContentListView(user: user)                    
                    }
                }
            }
            .sheet(isPresented: $showEditProfile, content: { 
                if let user = currentUser {
                    EditProfileView(user: user)                    
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) { 
                    Button { 
                        AuthService.shared.signOut()
                    } label: { 
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }

                }
            })
        }
        .padding(.horizontal)
    }
}

#Preview {
    CurrentUserProfileView()
}
