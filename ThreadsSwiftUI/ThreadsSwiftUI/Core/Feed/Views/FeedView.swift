//
//  FeedView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/2/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threads) { thread in 
                        ThreadView(thread: thread)
                    }
                }
            }
            .refreshable {
                print("DEBUG: refresh threads")
            }
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) { 
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundStyle(.black)
                })
            }
        })
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
