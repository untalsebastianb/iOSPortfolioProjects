//
//  videosAppSwiftDataApp.swift
//  videosAppSwiftData
//
//  Created by Juan Sebastian Bueno on 6/6/24.
//

import SwiftUI
import SwiftData

@main
struct videosAppSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(ViewModel())
        }
//        .modelContainer(for: [Video.self, Metadata.self]) moved to viewModel
    }
}
