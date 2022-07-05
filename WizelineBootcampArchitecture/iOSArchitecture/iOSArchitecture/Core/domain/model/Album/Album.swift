//
//  Album.swift
//  iOSArchitecture
//
//  Created by Sebastian on 4/07/22.
//

import Foundation

struct AlbumList: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    let collectionName, collectionCensoredName: String?
    let artistType: String?
    let artistName: String
    let artistLinkURL: String?
    let collectionType: String?
}
