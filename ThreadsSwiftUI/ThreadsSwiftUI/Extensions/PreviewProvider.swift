//
//  PreviewProvider.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 5/14/24.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    static let user = User(id: UUID().uuidString, fullname: "Max Verstappen", email: "maxv@gmail.com", username: "maxverstappen11", profileImageUrl: nil, bio: nil)
}
