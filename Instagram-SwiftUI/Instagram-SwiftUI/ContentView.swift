//
//  ContentView.swift
//  Instagram-SwiftUI
//
//  Created by Sebastian on 29/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing:0) {
                Divider().overlay(Color("primary")).frame(height: 1).opacity(0.4)
                ScrollView {
                    VStack {
                        storyList
                        Divider().overlay(Color("primary")).frame(height: 1).opacity(0.4)
                        
                        ForEach(viewModel.timeLineList) { timeline in
                            TimelineView(timeline: timeline)
                        }
                    }
                    .toolbar {
                        self.toolbarView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var storyList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.storyList) { story in
                    StoryView(story: story)
                }
            }
            .padding(.leading, 10)
            .padding(.vertical,10)
        }
    }
    
    
    @ToolbarContentBuilder
    func toolbarView() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {}) {
                Image("camera-Icon")
                    .renderingMode(.template)
                    .foregroundColor(Color("primary"))
            }
        }
        
        ToolbarItem(placement: .principal) {
            Image("instagram-logo")
                .renderingMode(.template)
                .foregroundColor(Color("primary"))
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                Button(action: {}) {
                    Image("igtv")
                        .renderingMode(.template)
                        .foregroundColor(Color("primary"))
                }
                Button(action: {}) {
                    Image("messanger")
                        .renderingMode(.template)
                        .foregroundColor(Color("primary"))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
