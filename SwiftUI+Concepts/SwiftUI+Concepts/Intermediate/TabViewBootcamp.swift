//
//  TabViewBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 7/8/24.
//

import SwiftUI

struct TabViewBootcamp: View {
    @State var selectedTab: Int = 0
    let icons: [String] = [
        "heart.fill",
        "globe",
        "house.fill",
        "person.fill"
    ]
    var body: some View {
        TabView(content: { 
            ForEach(icons, id: \.self, content: { icon in
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .padding(30)
            })
            
        })
        .background(Color.red)
        .frame(height: 300)
        .tabViewStyle(.page)
        
        
        
//        TabView(selection: $selectedTab, content: { 
//            ZStack {
//                Color.gray
//                VStack {
//                    Text("HomeTab")
//                        .font(.largeTitle)
//                        .foregroundStyle(.white)
//                    
//                    Button(action: {
//                        selectedTab = 2
//                    }, label: {
//                        Text("Go to profile")
//                            .font(.headline)
//                            .padding()
//                            .padding(.horizontal)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                    })
//                }
//            }
//            .tabItem {
//                Image(systemName: "house.fill")
//                Text("Home")
//            }
//            .tag(0)
//            
//            Text("Browse Tab")
//                .tabItem { 
//                    Image(systemName: "globe")
//                    Text("Browse")
//                }
//                .tag(1)
//            
//            Text("Profile")
//                .tabItem { 
//                    Image(systemName: "person.fill")
//                    Text("Profile")
//                }
//                .tag(2)
//        })
        .accentColor(.red)
    }
}

#Preview {
    TabViewBootcamp()
}
