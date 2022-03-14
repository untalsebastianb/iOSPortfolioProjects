//
//  Models.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import Foundation

struct User: Codable {
    let email: String
    let names: String
    let nickname: String
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}

struct ErrorResponse: Codable {
    let error: String
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let user: User
    let token: String
}

struct RegisterRequest: Codable {
    let email: String
    let names: String
    let password: String
}

struct RegisterResponse: Codable {
    let user: User
    let token: String
}

struct TwiitResponse: Codable {
    let id: String
    let author: User
    let imageUrl: String
    let text: String
    let videoUrl: String
    let location: Location
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}

struct Twiit: Codable {
    let imageUrl: String?
    let text: String
    let videoUrl: String?
    let location: Location?
}

struct DeleteTwiitResponse: Codable {
    let isDone: Bool
    let message: String
}
