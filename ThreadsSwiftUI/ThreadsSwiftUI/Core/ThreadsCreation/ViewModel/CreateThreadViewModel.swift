//
//  CreateThreadViewModel.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/19/24.
//

import Foundation
import Firebase

class CreateThreadViewModel: ObservableObject {
    
    func uploadThread(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timeStamp: Timestamp(), likes: 0)
        try await ThreadService.uploadThread(thread)
    }
}
