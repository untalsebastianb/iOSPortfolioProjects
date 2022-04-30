//
//  ContentView.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            NavigationLink {
                AddNote()
            } label: {
                Text("Add a note")
            }
            
            NavigationLink {
                ListNotes()
            } label: {
                Text("Check notes")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
