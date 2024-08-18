//
//  User.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
        .init(
            id: 777,
            firstName: "Juancho",
            lastName: "Bueno",
            maidenName: "",
            age: 28,
            email: "juancho@gmail.com",
            phone: "",
            username: "Juancho9507",
            password: "",
            image: "",
            height: 0.0,
            weight: 0.0
        )
    }
}
