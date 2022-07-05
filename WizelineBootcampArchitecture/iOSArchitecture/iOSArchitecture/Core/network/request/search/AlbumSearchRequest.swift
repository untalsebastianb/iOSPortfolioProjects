//
//  AlbumSearchRequest.swift
//  iOSArchitecture
//
//  Created by Sebastian on 4/07/22.
//

import Foundation

class AlbumSearchRequest: RequestProtocol {
    
    var id: Int
    
    init(id: Int = 0) {
        self.id = id
    }
    
    var path: String {
        return "/lookup"
    }

    var parameters: [String : String] {
        return [
            "id": "\(id)",
            "entity": "album"
        ]
    }
    
    
}
