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
    var databaseError: DatabaseError?
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesProtocol
    var updateNoteUseCase: UpdateNotesProtocol
    var removeNoteUseCase: RemoveNoteProtocol
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         updateNoteUseCase: UpdateNotesProtocol = UpdateNotesUseCase(),
         removeNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.removeNoteUseCase = removeNoteUseCase
        fetchAllNotes()
    }
    
    func createNoteWith(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllNotesUseCase.fetchAll()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func updateNote(identifier: UUID, newTitle: String, newText: String?) {
        do {
            try updateNoteUseCase.updateNoteWith(identifier: identifier, title: newTitle, text: newText)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func removeNoteWith(identifier: UUID) {
        do {
            try removeNoteUseCase.removeNoteWith(identifier: identifier)
            
        } 
        catch let error as DatabaseError {
            print("Error \(error.localizedDescription)")
            databaseError = error
        }
        catch  {
            print("Error \(error.localizedDescription)")
        }
    }
}
