//
//  ThreadService.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/19/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ThreadService {
    
    
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
}
