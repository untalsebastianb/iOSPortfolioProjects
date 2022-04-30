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
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            TextField("Write a note", text: $text)
            Button("Add note"){
                guard text.isEmpty == false else {
                    return
                }
                let note = Note(title: text)
                notes.append(note)
                Tools.shared.save(notes: notes)
                text = ""
                presentation.wrappedValue.dismiss()
            }
        }.onAppear {
            notes = Tools.shared.load()
        }
        
    }
}

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote()
    }
}
