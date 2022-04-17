//
//  GamesView.swift
//  GameStream
//
//  Created by Sebastian on 14/04/22.
//

import SwiftUI
import Kingfisher

struct GamesView: View {
    
    @ObservedObject var games = ViewModel()
    @State var gameViewIsActive: Bool   = false
    @State var url: String              = ""
    @State var titulo: String           = ""
    @State var studio: String           = ""
    @State var calification: String     = ""
    @State var publicationYear: String  = ""
    @State var description: String      = ""
    @State var tags: [String]           = []
    @State var imgsUrl: [String]        = []
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            
            Color("Marine-Color").ignoresSafeArea()
            
            VStack{
                
                Text("Games")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{
                    LazyVGrid(columns: gridLayout, spacing: 8) {
                        
                        ForEach(games.gamesInfo, id: \.self) {
                            game in
                            
                            Button {
                                url = game.videosUrls.mobile
                                titulo = game.title
                                calification = game.contentRaiting
                                publicationYear = game.publicationYear
                                description = game.description
                                tags = game.tags
                                imgsUrl = game.galleryImages
                                
                                print("pulse el juego \(titulo)")
                                
                            } label: {
                                
                                KFImage(URL(string: game.galleryImages[0])!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle.init(cornerRadius: 4))
                                    .padding(.bottom, 12)
                            }

                        }
                        
                    }
                }
                
            }.padding(.horizontal)
            
            
            
            
        }.onAppear {
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
