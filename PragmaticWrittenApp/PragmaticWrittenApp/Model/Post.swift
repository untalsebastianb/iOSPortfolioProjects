//
//  Post.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 23/03/22.
//

import Foundation

struct PostResponseModel: Decodable {
    let results: [PostDetailResponseModel]
}

struct PostDetailResponseModel: Decodable {
    let name: String
    let url: String
}

struct PostAssetsResponseModel: Decodable {
    let sprites: PostImage
}

struct PostImage: Decodable {
    let frontImage: String
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}
