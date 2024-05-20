//
//  UserService.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/4/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("user").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("user").getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self )})
        // returns the user less the current user that is logged in 
        return users.filter({$0.id != currentUserUid })
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("user").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("user").document(currentUserUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
