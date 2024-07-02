//
//  UpdateNotesUseCase.swift
//  ToDoTestApp
//
//  Created by Juan Sebastian Bueno on 7/1/24.
//

import Foundation

protocol UpdateNotesProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws 
}

struct UpdateNotesUseCase: UpdateNotesProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        try notesDatabase.update(identifier: identifier, title: title, text: text)
    }
}
