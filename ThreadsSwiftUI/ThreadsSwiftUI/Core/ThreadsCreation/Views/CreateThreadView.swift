//
//  CreateThreadView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct CreateThreadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var caption = ""
    var body: some View {
        NavigationStack { 
            VStack { 
                HStack(alignment: .center, content: {
                    HStack(alignment: .top){
                        CircularProfileImageView()
                        VStack(alignment: .leading, spacing: 4, content: {
                            Text("Maxverstappen1")
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
