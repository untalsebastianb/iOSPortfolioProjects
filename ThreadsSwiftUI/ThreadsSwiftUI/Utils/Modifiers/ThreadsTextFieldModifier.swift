//
//  ThreadsTextFieldModifier.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 4/1/24.
//

import SwiftUI

struct ThreadsTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}

extension View {
    func textFieldModifier() -> some View {
        self.modifier(ThreadsTextFieldModifier())
    }
}
