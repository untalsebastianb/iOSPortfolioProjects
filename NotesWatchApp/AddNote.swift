//
//  AddNote.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct AddNote: View {
    
    @State private var notes = [Note]()
    @State private var text = ""
    
    var body: some View {
        VStack {
            TextField("Note", text: $text)
            Button("Add note"){
                guard text.isEmpty == false else {
                    return
                }
                let note = Note(title: text)
                notes.append(note)
                text = ""
                
                print("NOTESS:", notes)
            }
        }
        
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
