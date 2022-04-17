//
//  Model.swift
//  GameStream
//
//  Created by Sebastian on 14/04/22.
//

import Foundation

struct Games: Codable {
    var games:[Game]
}

struct Game: Codable, Hashable {
    var title: String
    var studio: String
    var contentRaiting: String
    var publicationYear: String
    var description: String
    var platforms: [String]
    var tags: [String]
    var videosUrls: VideoURL
    var galleryImages: [String]
}

struct VideoURL: Codable, Hashable {
    var mobile: String
    var tablet: String
}
