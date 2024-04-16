//
//  AuthService.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/10/24.
//

import Firebase

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
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil // this removes session locally and updates routing
    }
    
}
