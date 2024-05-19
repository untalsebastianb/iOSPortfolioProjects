//
//  CreateThreadView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct CreateThreadView: View {
    @StateObject var viewModel = CreateThreadViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var caption = ""
    
    private var user: User? {
        UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack { 
            VStack { 
                HStack(alignment: .center, content: {
                    HStack(alignment: .top){
                        CircularProfileImageView(user: user)
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text(user?.username ?? "")
                                .fontWeight(.semibold)
                            TextField("Start a thread...", text: $caption, axis: .vertical)
                        })
                        .font(.footnote)
                    }
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button(action: {
                            caption = ""
                        }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.gray)
                            })
                        }
                })
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("New Thread")
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
                        Button("Post") { 
                            Task { 
                                try await viewModel.uploadThread(caption: caption)
                                dismiss()
                            }
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .opacity(caption.isEmpty ? 0.5 : 1.0)
                        .disabled(caption.isEmpty)
                    }
            })
        }
    }
}

#Preview {
    CreateThreadView()
}
