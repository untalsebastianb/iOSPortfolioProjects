//
//  SignInViewModel.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 28/06/22.
//

import Combine
import Foundation

class SignInViewModel {
    
    @Published public private(set) var isAuthorized: Bool = false
    
    var username: String = ""
    var password: String = ""
    
    @objc public func signIn() {
        print("It is working!")
        if username == Credentials.username.value
            && password == Credentials.password.value {
            isAuthorized = true
        } else {
            print("Incorrect Credentials")
        }
    }
}

extension SignInViewModel {
    private enum Credentials {
        case username
        case password
        
        var value: String {
            switch self {
            case .username: return "osmar"
            case .password: return "password"
            }
        }
    }
}
