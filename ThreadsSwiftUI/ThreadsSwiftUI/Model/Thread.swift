//
//  Thread.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/19/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timeStamp: Timestamp
    var likes: Int
    
    var id: String {
        threadId ?? UUID().uuidString
    }
    
    var user: User?
}
