//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by Juan Sebastian Bueno on 10/6/23.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
