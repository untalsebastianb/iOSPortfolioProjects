//
//  ContentViewModel.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/15/24.
//

import Foundation
import Combine
import Firebase

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    }
}
