//
//  UserContentListViewModel.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/21/24.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var threads = [Thread]()
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserThreads() }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        for index in 0 ..< threads.count {
            threads[index].user = user
        }
        self.threads = threads
    }
    
}
