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
            
            Text("Favorites")
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
    
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            Color("Marine-Color").ignoresSafeArea()
            
            VStack {
                
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.horizontal, 20.0)
                
                HStack{
                    
                    Button(action: search, label: {
                        Image(systemName: "magnifyingglass").foregroundColor(searchText.isEmpty ? Color.yellow : Color("Dark-Cian") )
                    })
                    
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
                
                ScrollView(showsIndicators: false) {
                    HomeScreenSubModule()
                }
                
            }.padding(.horizontal, 18)
            
            
        }.hideNavigationBar()
       
            
    }
    
    func search() {
        print("Searching... \(searchText)")
    }
}

struct HomeScreenSubModule: View {
    
    @State var url = "https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4"
    @State var isPlayerActive = false
    let urlVideos:[String] = ["https://cdn.cloudflare.steamstatic.com/steam/apps/256658589/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256671638/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256720061/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256814567/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256705156/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256801252/movie480.mp4","https://cdn.cloudflare.steamstatic.com/steam/apps/256757119/movie480.mp4"]
    
    var body: some View {
        
        VStack{
            
            Text("Populars")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame( maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            ZStack{
                
                Button {
                    url = urlVideos[0]
                    print("URL: \(url)")
                    isPlayerActive = true
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
                        url = urlVideos[1]
                        print("URL: \(url)")
                        isPlayerActive = true
                    }) {
                        Image("Abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                        url = urlVideos[2]
                        print("URL: \(url)")
                        isPlayerActive = true
                    }) {
                        Image("Crash Bandicoot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                        url = urlVideos[3]
                        print("URL: \(url)")
                        isPlayerActive = true
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
                        url = urlVideos[4]
                        print("URL:", url)
                        isPlayerActive = true
                    }) {
                        Image("Grand Theft Auto V")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    }
                    
                    Button(action: {
                        url = urlVideos[5]
                        print("URL:", url)
                        isPlayerActive = true
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
        
        
        NavigationLink(isActive: $isPlayerActive,
                       destination: {
                        VideoPlayer(player: AVPlayer(url: URL(string: url)!))
                        .frame(width: 400, height: 400)
                        },
                       label: {
                        EmptyView()
                        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
