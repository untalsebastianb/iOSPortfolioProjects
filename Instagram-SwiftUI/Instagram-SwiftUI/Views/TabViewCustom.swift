//
//  TabViewCustom.swift
//  Instagram-SwiftUI
//
//  Created by Sebastian on 30/09/22.
//

import SwiftUI

enum TabViewIcons: String, CaseIterable {
    case home
    case magnifier
    case plusIcon = "plus-icon"
    case heart
    case profile
}

struct TabViewCustom: View {
    
    @State private var selectedTab: TabViewIcons = .home
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var icons: [TabViewIcons] = {
        var icon = TabViewIcons.allCases
        icon.removeLast()
        return icon
    }()
    
    let insets = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: {$0.isKeyWindow})?.safeAreaInsets ?? .zero
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                
                ContentView()
                    .tag(TabViewIcons.home)
                    .ignoresSafeArea()
                
                Color.red
                    .tag(TabViewIcons.magnifier)
                    .ignoresSafeArea()
                
                Color.black
                    .tag(TabViewIcons.plusIcon)
                    .ignoresSafeArea()
                
                Color.blue
                    .tag(TabViewIcons.heart)
                    .ignoresSafeArea()
                
                Color.brown
                    .tag(TabViewIcons.profile)
                    .ignoresSafeArea()
            }
            
            tabView
            
        }
    }
    
    private var tabView: some View {
        VStack(spacing: 0) {
            Divider().overlay(Color("primary")).frame(height: 1).opacity(0.4)
            HStack {
                ForEach(icons, id: \.self) { item in
                    Button {
                        selectedTab = item
                    } label: {
                        let selected = item == selectedTab ? "-selected": ""
                        Image(item.rawValue+selected)
                            .renderingMode(.template)
                            .foregroundColor(Color("primary"))
                    }
                    Spacer()
                }
                Button {
                    selectedTab = .profile
                } label: {
                    Image("person-1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23, height: 23)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(Color("primary"))
                                .opacity(selectedTab == .profile ? 1 : 0.1)
                                .padding(.all, -4)
                        }
                }
                
            }
            .padding(.top, 12)
            .padding(.bottom, insets.bottom == 0 ? 10 : 0)
            .padding(.horizontal, 26)
            .background(Color("tabBar-bg"))
        .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

struct TabViewCustom_Previews: PreviewProvider {
    static var previews: some View {
        TabViewCustom()
    }
}
