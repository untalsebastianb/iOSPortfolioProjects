//
//  FeedViewModel.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/19/24.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task {
            try await fetchThreads()
        }
    }
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchThreadUser()
    }
    
    private func fetchThreadUser() async throws {
        for index in 0..<threads.count {
            let thread = threads[index]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fetchUser(withUid: ownerUid)
            
            threads[index].user = threadUser
        }
    }
}
