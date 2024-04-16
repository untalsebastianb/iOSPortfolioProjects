//
//  LoginViewModel.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/15/24.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
     
     @MainActor
     func loginUser() async throws {
         try await AuthService.shared.login(withEmail: email, password: password)
     }
}
