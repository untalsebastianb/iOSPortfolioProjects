//
//  ThreadView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct ThreadView: View {
    let thread: Thread
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12, content: {
                CircularProfileImageView(user: thread.user, size: .regular)
                
                VStack(alignment: .leading, spacing: 4){
                    HStack {
                        Text(thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(thread.timeStamp.timestampString())
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.black)
                        })
                    }
                    
                    Text(thread.caption)
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
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ThreadView(thread: DeveloperPreview.thread)
}
