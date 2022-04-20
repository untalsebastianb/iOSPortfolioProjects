//
//  FavoritesView.swift
//  GameStream
//
//  Created by Sebastian on 19/04/22.
//

import SwiftUI
import AVKit

struct FavoritesView: View {
    
    @ObservedObject var games = ViewModel()
    
    var body: some View {
        ZStack {
            Color("Marine-Color")
                .ignoresSafeArea()
            
            VStack{
                Text("Favorites")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 9)
                
                ScrollView {
                    
                    ForEach(games.gamesInfo, id: \.self) {
                        game in
                        
                        
                        VStack(spacing: 0) {
                            VideoPlayer(player: AVPlayer(url: URL(string: game.videosUrls.mobile)!)).frame(height: 300)
                            Text(game.title)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("Blue-Gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 3.0))
                        }
                        
                        
                    }
                    
                }.padding(.bottom, 8)
            }
        }.hideNavigationBar()
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
