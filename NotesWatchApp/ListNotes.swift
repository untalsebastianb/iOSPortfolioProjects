//
//  ListNotes.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct ListNotes: View {
    @State var notes = [Note]()
    
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
            .onDelete(perform: delete)
        }
    }
    
    func delete(offset: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offset)
        }
        
    }
}

struct ListNotes_Previews: PreviewProvider {
    static var previews: some View {
        ListNotes()
    }
}
