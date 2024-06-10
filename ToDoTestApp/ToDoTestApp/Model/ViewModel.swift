//
//  ViewModel.swift
//  ToDoTestApp
//
//  Created by Juan Sebastian Bueno on 6/9/24.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    func createNoteWith(title: String, text: String) {
        let note: Note = .init(title: title, text: text, createdAt: .now)
        notes.append(note)
    }
    
    func updateNote(id: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: {$0.id == id }) {
            let updatedNote = Note(id: id, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            notes[index] = updatedNote
        }
    }
    
    func removeNoteWith(id: UUID) {
        notes.removeAll(where: { $0.id == id })
    }
}
