//
//  AuthService.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/10/24.
//

import Firebase
import FirebaseFirestore

class AuthService {
    @Published var userSession: FirebaseAuth.User?

    static let shared = AuthService()
    
    init() {
        // if have value someone is logged in
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            try await UserService.shared.fetchCurrentUser()
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullName: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            try await uploadUserData(withEmail: email, fullName: fullName, username: username, id: result.user.uid)
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signOut() {
        try? Auth.auth().signOut() // signs out on backend
        self.userSession = nil // this removes session locally and updates routing
        UserService.shared.reset() // sets current user to nil 
    }
    
    @MainActor
    private func uploadUserData(withEmail email: String,
                                fullName: String,
                                username: String,
                                id: String) async throws {
        let user = User(id: id, fullname: fullName, email: email, username: username, profileImageUrl: nil, bio: nil)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("user").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
    
}
