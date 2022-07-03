//
//  MusicSearchRequest.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Foundation

class MusicSearchRequest: RequestProtocol {
    var song: String
    
    init(song: String = "") {
        self.song = song
    }
    
    var path: String {
        return "/search"
    }
    
    var parameters: [String : String] {
        return [
            "media" : "music",
            "entity" : "song",
            "term" : song
        ]
    }
}
