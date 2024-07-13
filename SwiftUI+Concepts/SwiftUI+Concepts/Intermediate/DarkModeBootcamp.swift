//
//  DarkModeBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 7/13/24.
//

import SwiftUI

struct DarkModeBootcamp: View {
    // MARK: Properties
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView(content: {
            foregroundLayer
                .navigationTitle("Dark Mode")
        })
    }
    
    /// This is the foreground layer that holds the scrollview
    private var foregroundLayer: some View {
        ScrollView {
            VStack(spacing: 20, content: {
                // adaptive colors
                Text("This Text is primary")
                    .foregroundStyle(.primary)
                // adaptive colors
                Text("This color is SECONDARY")
                    .foregroundStyle(.secondary)
                // NOT adaptive colors
                Text("This Color is BLACK")
                    .foregroundStyle(.black)
                
                Text("This color is WHITE")
                    .foregroundStyle(.white)
                
                Text("This color is Globally Adaptive")
                    .foregroundStyle(Color("AdaptiveColor"))
                
                Text("This color is locally Adaptive")
                    .foregroundStyle(colorScheme == .light ? .green : .red)
            })
        }
    }
}

#Preview {
    DarkModeBootcamp()
            .preferredColorScheme(.light)
}
