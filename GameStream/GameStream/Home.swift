//
//  Home.swift
//  GameStream
//
//  Created by Sebastian on 29/03/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        TabView {
           
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            Text("Game Screen")
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }
            
            Text("Home Screen")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Favorites")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
