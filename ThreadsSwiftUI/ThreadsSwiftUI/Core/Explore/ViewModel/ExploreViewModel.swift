//
//  ExploreViewModel.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/11/24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }

    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
    
    
}
