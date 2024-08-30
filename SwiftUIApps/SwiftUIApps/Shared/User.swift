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
    
    var work: String {
        "Worker at some job"        
    } 
    var education: String {
        "Graduate Degree"        
    }
    
    var aboutMe: String {
        "This is a sentence about me that will look good on my profile"
    }
    
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", text: "\(height)"),
            UserInterest(iconName: "graduationcap", text: "\(education)"),
            UserInterest(iconName: "wineglass", text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", text: "Virgo"),
            
        ]
    }
    
    var interest: [UserInterest] {
        [
            UserInterest(emoji: "🏃‍➡️", text: "Running"),
            UserInterest(emoji: "🍕", text: "Good food"),
            UserInterest(emoji: "🏀", text: "Basketball"),
            UserInterest(emoji: "🇨🇦", text: "Canada"),
            
        ]
    }
    
    var images: [String] {
        [
            "https://picsum.photos/700",
            "https://picsum.photos/200",
            "https://picsum.photos/300"
        ]
    }
    
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
            image: "https://picsum.photos/200",
            height: 0.0,
            weight: 0.0
        )
    }
}
