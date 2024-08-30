//
//  InterestPillGridView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 8/28/24.
//

import SwiftUI
import SwiftfulUI

struct UserInterest: Identifiable {
    let id = UUID().uuidString
    var iconName: String? = nil
    var emoji: String? = nil
    var text: String
}

struct InterestPillGridView: View {
    var interest: [UserInterest] = User.mock.basics
    var body: some View {
        ZStack {
            NonLazyVGrid(columns: 2, alignment: .leading, spacing: 8, items: interest) { interest in
                if let interest {
                    InterestPillView(iconName: interest.iconName, emoji: interest.emoji, text: interest.text)
                }
            }
        }
    }
}

#Preview {
    VStack {
        InterestPillGridView(interest: User.mock.basics)
        InterestPillGridView(interest: User.mock.interest)
    }
}
