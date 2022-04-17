//
//  GameView.swift
//  GameStream
//
//  Created by Sebastian on 17/04/22.
//

import SwiftUI

struct gameDTO {
    var url: String
    var title: String
    var studio: String
    var calification: String
    var publicationYear: String
    var description: String
    var tags: [String]
    var imgsUrl: [String]
}

struct GameView: View {
    var game: gameDTO?
    var body: some View {
        ZStack {
            Color("Marine-Color").ignoresSafeArea()
            VStack {
                Text("\(game!.title) \(game!.publicationYear)")
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: gameDTO(url: "ejemplo.com", title: "Sonic", studio: "Sega", calification: "1.2", publicationYear: "1995", description: "Best video game", tags: ["pet", "platform"], imgsUrl: ["mockUrlImage"]))
    }
}
