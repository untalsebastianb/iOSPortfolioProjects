//
//  Video.swift
//  videosAppSwiftData
//
//  Created by Juan Sebastian Bueno on 6/6/24.
//

import Foundation
import SwiftData

@Model
class Video {
    @Attribute(.unique) var id: UUID
    var title: String
    @Relationship(deleteRule: .cascade) var medatadata: Metadata
    
    @Transient var numberOfLikes: Int { title.count }
    
    init(id: UUID, title: String, metadata: Metadata) {
        self.id = id
        self.title = title
        self.medatadata = metadata
    }
}

@Model
class Metadata {
    var isFavorite: Bool 
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
