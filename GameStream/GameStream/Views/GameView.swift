//
//  GameView.swift
//  GameStream
//
//  Created by Sebastian on 17/04/22.
//

import SwiftUI
import AVKit
import Kingfisher

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

struct GameGallery: View {
    
    var imgsUrl: [String]
    let layout = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gallery")
                .foregroundColor(.white)
                .font(.title3)
                .padding(.leading)
            
            ScrollView(.horizontal){
                LazyHGrid(rows: layout, spacing: 8){
                    
                    ForEach(imgsUrl, id: \.self) {
                        url in
                        KFImage(URL(string: url))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    
                }
            }.frame(height: 180)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct CommentCard: View {
    
    var data: [GameCommentInfo]
    
    var body: some View {
        
        ForEach(data, id: \.self) {
            comment in
            ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 8.0)
                        .fill(Color("TabBar-Color"))
                    VStack(alignment: .leading){
                        HStack(alignment: .top){
                            Image(comment.profileImg)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(comment.user)
                                    .font(.body)
                                    .foregroundColor(.white)
                                Text(comment.time)
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                        }.padding(.bottom)
                        
                        Text(comment.commentText)
                            .lineLimit(nil)
                            .foregroundColor(.white)
                            .font(.body)
                        
                        
                    }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 5))
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

struct GameCommentInfo: Hashable {
    var profileImg: String
    var user: String
    var time: String
    var commentText: String
}

struct GameCommentsView: View {
    
    var gameComments: [GameCommentInfo]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Comments")
                .foregroundColor(.white)
                .font(.title3)
                .padding(.leading)
            
            CommentCard(data: gameComments)
        }
            
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
                        
                        GameGallery(imgsUrl: game.imgsUrl)
                        GameCommentsView(gameComments: [GameCommentInfo(profileImg: "Abzu", user: "Sebastian", time: "1 month ago", commentText: "The game is truly good"), GameCommentInfo(profileImg: "Hades", user: "Camilo", time: "6 months ago", commentText: "GREAT GAME")])
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
