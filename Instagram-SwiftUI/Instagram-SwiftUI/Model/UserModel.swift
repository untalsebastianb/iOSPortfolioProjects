//
//  UserModel.swift
//  Instagram-SwiftUI
//
//  Created by Sebastian on 29/09/22.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    let username: String
    let profilePicture: String
    let city: String
    let isVerified: Bool
    
    static func getUsers() -> [UserModel] {
        return [
            .init(username: "untalsebastianbueno", profilePicture: "sebastianDev", city: "Cali, Colombia", isVerified: true),
            .init(username: "jalonso98", profilePicture: "person-12", city: "Seattle, US", isVerified: true),
            .init(username: "guga", profilePicture: "person-1", city: "Germany, Europe", isVerified: false),
            .init(username: "the_world", profilePicture: "person-7", city: "Texas, US", isVerified: false),
            .init(username: "ntobon09", profilePicture: "person-17", city: "Medellin, Colombia", isVerified: true),
            .init(username: "dcorredor", profilePicture: "person-13", city: "Bogota, Colombia", isVerified: false),
            .init(username: "karenne", profilePicture: "person-6", city: "Paris, France", isVerified: false),
            .init(username: "melandrexz", profilePicture: "person-11", city: "Cali, Colombia", isVerified: true),
            .init(username: "ozkarinfo", profilePicture: "person-8", city: "San Andres, Colombia", isVerified: true),
        ]
    }
}

struct StoryModel: Identifiable {
    let id = UUID()
    let user: UserModel
    let isLive: Bool
    
    static func getStories() -> [Self] {
        return UserModel.getUsers().map{ StoryModel(user: $0, isLive: ([true, false].randomElement())!)}
    }
}

struct TimelineModel: Identifiable {
    let id = UUID()
    let photo: String
    let user: UserModel
    
    static func getPost() -> [Self] {
        return (1..<10).map { TimelineModel(photo: "post-\($0)", user: UserModel.getUsers().randomElement()!)}
    }
}

struct CommentModel: Identifiable {
    let id = UUID()
    let comment: String
    
    static func getComments() -> [Self] {
        return [
            .init(comment: "Excuse me, folks. Everyone needs to double-tap on this picture ASAP. It's the most beatiful thing you'll ever see"),
            .init(comment: "Live for the moments you cannot put into words"),
            .init(comment: "So you have been this cool since day one?"),
            .init(comment: "This is a perfect example of a quality portrait of a quality humang being.")
        ]
    }
}
