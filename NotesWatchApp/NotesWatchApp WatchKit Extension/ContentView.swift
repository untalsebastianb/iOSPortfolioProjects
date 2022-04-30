//
//  ContentView.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        let note = Note(title: "Note", creationDate: "22-22-2022")
        Text("\(note.title) - \(note.creationDate)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
