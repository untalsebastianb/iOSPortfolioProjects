//
//  ListNotes.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct ListNotes: View {
    var notes: [Note] = [Note(title: "One"), Note(title: "Two"), Note(title: "Three ")]
    
    var body: some View {
        List {
            ForEach(0..<notes.count, id: \.self) {
                i in
                NavigationLink(
                    destination: NoteDetail(note: notes[i]),
                    label: {
                    Text("\(notes[i].title)")
                        .lineLimit(1)
                })
            }
        }
    }
}

struct ListNotes_Previews: PreviewProvider {
    static var previews: some View {
        ListNotes()
    }
}
