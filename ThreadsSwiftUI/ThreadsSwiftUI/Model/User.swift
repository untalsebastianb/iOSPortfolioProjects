//
//  User.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/4/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    let profileImageUrl: String?
    let bio: String?
}
