//
//  GameView.swift
//  GameStream
//
//  Created by Sebastian on 17/04/22.
//

import SwiftUI
import AVKit

struct GameDTO {
    var url: String
    var title: String
    var studio: String
    var calification: String
    var publicationYear: String
    var description: String
    var tags: [String]
    var imgsUrl: [String]
}

struct GameVideoView: View {
    var url: String
    var body: some View {
        VideoPlayer(player: AVPlayer(url: URL(string: url)!))
            .ignoresSafeArea()
    }
}

struct GameInfoView: View {
    var game: GameDTO
    var body: some View {
        VStack(alignment: .leading){
            Text("\(game.title)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            
            HStack {
                Text("\(game.studio)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.leading)
                
                Text("\(game.calification)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.leading)
                
                Text("\(game.publicationYear)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.leading)
                
            }
            
            Text("\(game.description)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5)
                .padding(.leading)
            
            HStack {
                ForEach(game.tags, id: \.self) {
                    tag in
                    
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top, 4)
                        .padding(.leading)
                }
            }
            
            
            
        }.frame( maxWidth: .infinity, alignment: .leading)
    }
}

struct GameView: View {
    var game: GameDTO?
    var body: some View {
        ZStack {
            Color("Marine-Color").ignoresSafeArea()
            VStack {
                GameVideoView(url: game?.url ?? "").frame(height: 300)
                
                ScrollView {
                    if let game = game {
                        GameInfoView(game: GameDTO(url: game.url,
                                                    title: game.title,
                                                    studio: game.studio,
                                                    calification: game.calification, publicationYear: game.publicationYear,
                                                    description: game.description,
                                                    tags: game.tags,
                                                    imgsUrl: [""]))
                            .padding(.bottom)
                    }
                    
                }.frame(maxWidth: .infinity)
                
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: GameDTO(url: "ejemplo.com",
                               title: "Sonic",
                               studio: "Sega",
                               calification: "1.2",
                               publicationYear: "1995",
                               description: "Best video game",
                               tags: ["pet", "platform"],
                               imgsUrl: ["mockUrlImage"]))
    }
}
