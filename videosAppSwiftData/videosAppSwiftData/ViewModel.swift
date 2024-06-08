//
//  ViewModel.swift
//  videosAppSwiftData
//
//  Created by Juan Sebastian Bueno on 6/8/24.
//

import Foundation
import SwiftData

@Observable
final class ViewModel: ObservableObject {
    let container = try! ModelContainer(for: Video.self, Metadata.self)
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
    }
    
    var videos: [Video] = []
    
    @MainActor
    func getVideos() {
        let fetchDescriptor = FetchDescriptor<Video>(predicate: nil,
                                                     sortBy: [SortDescriptor<Video>(\.title)])
        videos = try! modelContext.fetch(fetchDescriptor)
        print(videos)
    }
    
    @MainActor
    func insert(video: Video) {
        videos.append(video)
        modelContext.insert(video)
//        videos = []
//        getVideos()
    }
    
    @MainActor
    func deleteVideos() {
        videos.forEach {
            modelContext.delete($0)
        }
        videos = []
        getVideos()
    }
    
}
