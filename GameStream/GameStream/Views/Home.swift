//
//  Home.swift
//  GameStream
//
//  Created by Sebastian on 29/03/22.
//

import SwiftUI
import AVKit

struct Home: View {
    @State var selectedTab: Int = 2
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
           
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(0)
            
            GamesView()
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Games")
                }.tag(1)
            
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(2)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }.tag(3)
        }.accentColor(.white)
        
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("TabBar-Color"))
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
        UITabBar.appearance().isTranslucent = true
    }
    
}


struct HomeScreen: View {

    var body: some View {
        ZStack {
            Color("Marine-Color").ignoresSafeArea()
            
            VStack {
                
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.horizontal, 20.0)
                
                
                ScrollView(showsIndicators: false) {
                    HomeScreenSubModule()
                }
                
            }.padding(.horizontal, 18)
            
            
        }.hideNavigationBar()
       
            
    }
}

struct HomeScreenSubModule: View {
    
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    @State var searchText = ""
    @State var isGameInfoEmpty = false
    @ObservedObject var endpoint = SearchGame()
    @State var isGameViewActive = false
    @State var foundGame: GameDTO?
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Button(action: {
                    searchGame(name: searchText)
                    
                },
                       label: {
                    Image(systemName: "magnifyingglass").foregroundColor(searchText.isEmpty ? Color.yellow : Color("Dark-Cian") )
                }).alert(isPresented: $isGameInfoEmpty) {
                    Alert(title: Text("Error"), message: Text("Game not found"), dismissButton: .default(Text("OK")))
                }
                
                ZStack(alignment: .leading) {
                    
                    if searchText.isEmpty {
                        Text("Search a video").foregroundColor(.gray)
                    }
                    TextField("", text: $searchText).foregroundColor(.white)
                    
                    
                }
                
                
            }
            .padding([.top, .leading, .bottom], 11.0)
            .background(Color("Blue-Gray"))
            .clipShape(Capsule())
            
            Text("Populars")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame( maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ZStack{
                
                Button {
                    searchGame(name: "The Witcher 3")
                } label: {
                    VStack(spacing: 0) {
                        Image("The Witcher 3")
                            .resizable()
                            .scaledToFill()
                        Text("The Witcher 3")
                            .frame( maxWidth: .infinity, alignment: .leading)
                            .background(Color("Blue-Gray"))
                    }
                    
                }
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
            

                
            }.frame( maxWidth: .infinity, alignment: .center)
                .padding(.vertical)
            
            Text("SUGGESTED CATEGORIES")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame( maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("Blue-Gray"))
                                .frame(width: 160, height: 90)
                            
                            Image("FPS")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("Blue-Gray"))
                                .frame(width: 160, height: 90)
                            
                            Image("RPG")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                    Button(action: {}) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("Blue-Gray"))
                                .frame(width: 160, height: 90)
                            
                            Image("OpenWorld")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                    
                }
            }
            
            Text("RECOMMENDED")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame( maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Button(action: {
                        searchGame(name: "Abzu")
                    }) {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                        searchGame(name: "Crash Bandicoot")
                    }) {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                        searchGame(name: "DEATH STRANDING")
                    }) {
                        Image("DEATH STRANDING")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
            
            Text("Videos you might like")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack  {
                    Button(action: {
                        searchGame(name: "Grand Theft Auto V")
                    }) {
                        Image("Grand Theft Auto V")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                        searchGame(name: "Hades")
                    }) {
                        Image("Hades")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                }
            }
            .padding(.bottom)
            
            
            
        }
        NavigationLink(isActive: $isGameViewActive,
                       destination: {
                        GameView(game: foundGame)
                        },
                       label: {
                        EmptyView()
                        })
    }
    
    func searchGame(name: String) {
        
        endpoint.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            print("Quantity E: \(endpoint.gameInfo.count)")
            
            if endpoint.gameInfo.count == 0 {
                isGameInfoEmpty = true
            } else {
               foundGame = GameDTO(url: endpoint.gameInfo[0].videosUrls.mobile, title: endpoint.gameInfo[0].title, studio: endpoint.gameInfo[0].studio, calification: endpoint.gameInfo[0].contentRaiting, publicationYear: endpoint.gameInfo[0].publicationYear, description: endpoint.gameInfo[0].description, tags: endpoint.gameInfo[0].tags, imgsUrl: endpoint.gameInfo[0].galleryImages)
                
                isGameViewActive = true
            }
        }
        
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
