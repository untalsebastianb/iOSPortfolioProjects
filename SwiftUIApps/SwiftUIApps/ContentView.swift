//
//  ContentView.swift
//  SwiftUIApps
//
//  Created by Juan Sebastian Bueno on 7/31/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router 
    
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { router in
                    SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
                }
            }
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { router in
                    BumbleHomeView()
                }
            }
            
            Button("Open Netflix") {
                router.showScreen(.fullScreenCover) { router in
                    NetflixHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in 
        ContentView()
    }
}
