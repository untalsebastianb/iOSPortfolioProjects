//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 11/13/23.
//

import Foundation
import SwiftUI

class HapticManager {
    private static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
