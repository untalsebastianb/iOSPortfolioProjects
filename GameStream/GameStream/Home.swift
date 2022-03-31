//
//  Home.swift
//  GameStream
//
//  Created by Sebastian on 29/03/22.
//

import SwiftUI

struct Home: View {
    @State var selectedTab: Int = 2
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
           
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(0)
            
            Text("Game Screen")
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
                
                
            }.padding(.horizontal, 18)
            
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
    
    func search() {
        print("Searching... \(searchText)")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
