//
//  ContentView.swift
//  videosAppSwiftData
//
//  Created by Juan Sebastian Bueno on 6/6/24.
//

import SwiftUI
import SwiftData

// route to DB
// "/Users/j.bueno/Library/Developer/CoreSimulator/Devices/45FC6108-4A64-4838-A026-D3AA13E8AACE/data/Containers/Data/Application/527F72CB-EFF7-415E-B278-6133A794E9B6/Library/Application Support/default.store"

struct ContentView: View {
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Video.title) var videos: [Video] 
//    @Query(filter: #Predicate { (video: Video) in 
//        video.title == "SwiftData" }, animation: .default) var videos: [Video]
    @Environment(ViewModel.self) var viewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.videos) { video in
                    NavigationLink(value: video) {
                        HStack {
                            Text(video.title)
                            if video.medatadata.isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Videos")
            .navigationDestination(for: Video.self, destination: { video in
                UpdateView(video: video)
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        withAnimation(.easeIn) { 
                            let newVideo = Video(id: .init(),
                                                 title: "SwiftData",
                                                 metadata: .init(isFavorite: true))
                            viewModel.insert(video: newVideo)
                        }
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        withAnimation(.easeOut(duration: 4)) { 
//                            viewModel.videos.forEach { video in
//                                modelContext.delete(video)
//                            }
                            viewModel.deleteVideos()
//                            try? modelContext.save()
                        }
                    }, label: {
                        Label("Delete Items", systemImage: "trash")
                    })
                })
            })
        }
        .onAppear(perform: {
            viewModel.getVideos()
        })
    }
}
