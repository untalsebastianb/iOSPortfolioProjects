//
//  GamesView.swift
//  GameStream
//
//  Created by Sebastian on 14/04/22.
//

import SwiftUI

struct GamesView: View {
    
    @ObservedObject var games = ViewModel()
    
    var body: some View {
        Text("Hello, fron games view!")
            .onAppear {
                print("First element of json: \(games.gamesInfo[0])")
                print("The view is showing \(games.gamesInfo[0].title)")
            }
            .hideNavigationBar()
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}
