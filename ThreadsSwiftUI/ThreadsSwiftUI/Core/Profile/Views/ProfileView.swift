//
//  ProfileView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    private var filterBarWidht: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) { 
                // bio and stats
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 12) {
                            // fullname and username
                            VStack(alignment: .leading, spacing: 4, content: {
                                Text("Charles Leclerc")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("charles_leclerc")
                                    .font(.subheadline)
                            })
                            
                            Text("Formula 1 Driver for Scuderia Ferari")
                                .font(.footnote)
                            
                            Text("2 followers")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        CircularProfileImageView(size: .big)
                    }
                    
                    Button { 
                        
                    } label: { 
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 352, height: 32)
                            .background(.black)
                            .cornerRadius(8)
                    }
                    
                    //user content list view
                    VStack( content: {
                        HStack(content: {
                            ForEach(ProfileThreadFilter.allCases) { filter in
                                VStack(content: {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                    
                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundStyle(.black)
                                            .frame(width: filterBarWidht, height: 1)
                                            .matchedGeometryEffect(id: "item", in: animation)
                                    } else {
                                        Rectangle()
                                            .foregroundStyle(.clear)
                                            .frame(width: filterBarWidht, height: 1)
                                    }
                                })
                                .onTapGesture {
                                    withAnimation(.spring()) { 
                                        selectedFilter = filter
                                    }
                                }
                            }
                        })
                        LazyVStack {
                            ForEach(0 ... 10, id: \.self) { thread in
                                ThreadView()
                            }
                        }
                    })
                    .padding(.vertical, 8)
                }
            }
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
    ProfileView()
}
