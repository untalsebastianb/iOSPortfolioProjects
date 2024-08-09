//
//  SpotifyHomeView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/8/24.
//

import SwiftUI

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    var body: some View {
        ZStack { 
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) { 
                LazyVStack(pinnedViews: [.sectionHeaders], content: {
                    Section { 
                        ForEach(0..<10) { _ in
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 30, height: 30)
                        }
                    } header: { 
                        header
                    }

                })
                .padding(.top, 8)
                
            }
            .scrollIndicators(.hidden)
            .clipped()
            .task {
                await getData()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            // tip keep the frame on the view hierarchy
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            
                        }                    
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal, showsIndicators: false) { 
                HStack(spacing: 8, content: {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                })
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifyBlack)
    }
    
    private func getData() async {
        do {
            currentUser = try await DataBaseHelper().getUsers().first
//            products = try await DataBaseHelper().getProducts()
        } catch  {
            print("error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    SpotifyHomeView()
}
