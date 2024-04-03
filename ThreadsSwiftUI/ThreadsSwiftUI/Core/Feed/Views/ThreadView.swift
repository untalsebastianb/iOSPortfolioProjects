//
//  ThreadView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct ThreadView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12, content: {
                CircularProfileImageView()
                
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        Text("Hamilton142")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.black)
                        })
                    }
                    
                    Text("Formula 1 best driver")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16, content: {
                        Button(action: {}, label: {
                            Image(systemName: "heart")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "bubble.right")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "arrow.rectanglepath")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "paperplane")
                        })
                    })
                    .foregroundStyle(.black)
                    .padding(.vertical, 8)
                }
            })
            
            Divider()
        }
        .padding()
    }
}

#Preview {
    ThreadView()
}
