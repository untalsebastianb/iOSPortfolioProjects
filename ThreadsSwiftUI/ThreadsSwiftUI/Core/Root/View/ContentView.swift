//
//  ContentView.swift
//  ThreadsSwiftUI
//
//  Created by Juan Sebastian Bueno on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ThreadsTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
