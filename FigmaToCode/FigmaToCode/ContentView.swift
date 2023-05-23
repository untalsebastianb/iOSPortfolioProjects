//
//  ContentView.swift
//  FigmaToCode
//
//  Created by Juan Sebastian Bueno on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        TabView {
            NavigationView {
                TaskListView()
            }
            .tabItem {
                Image("ic-task")
                    .renderingMode(.template)
            }

            InboxView()
                .tabItem {
                    Image("ic-reminder")
                        .renderingMode(.template)
                }
            RemindersView()
                .tabItem {
                    Image("ic-timer")
                        .renderingMode(.template)
                }
            SettingsView()
                .tabItem {
                    Image("ic-settings")
                        .renderingMode(.template)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
