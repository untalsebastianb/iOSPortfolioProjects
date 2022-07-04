//
//  Song.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Foundation

struct SongList: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let name: String
    let artist: String
    let previewUrl: String
    let artistID: Int
    
    init(name: String, artist: String, previewUrl: String = "", artistID: Int) {
        self.name = name
        self.artist = artist
        self.previewUrl = previewUrl
        self.artistID = artistID
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case previewUrl = "previewUrl"
        case artistID = "artistId"
    }
}
