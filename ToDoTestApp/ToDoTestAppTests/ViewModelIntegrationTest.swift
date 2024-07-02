//
//  ViewModelIntegrationTest.swift
//  ToDoTestAppTests
//
//  Created by Juan Sebastian Bueno on 7/1/24.
//

import XCTest
@testable import ToDoTestApp

@MainActor
final class ViewModelIntegrationTest: XCTestCase {
    var sut: ViewModel!

    override func setUpWithError() throws {
        let database = NotesDatabase.shared
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllNotesUseCase: fetchAllNotesUseCase)
    }

    override func tearDownWithError() throws {
    }
    
    func testCreateNote() {
        // given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        
        // when 
        let note = sut.notes.first
        
        // then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "hello 1")
        XCTAssertEqual(note?.text, "text 1")
        XCTAssertEqual(sut.notes.count, 1, "there should be 1 note in DB")
    }
    
    func testFetchAllNotes() {
        // given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        sut.createNoteWith(title: "hello 2", text: "text 2")
        
        // when 
        let firstNote = sut.notes.first
        let secondNote = sut.notes.last
        
        // then
        XCTAssertEqual(sut.notes.count, 2, "There should be 2 notes in DB")
    }
    
    func testCreateTwoNotes() {
        // given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        sut.createNoteWith(title: "hello 2", text: "text 2")
        
        // when 
        let firstNote = sut.notes.first
        let secondNote = sut.notes.last
        
        // then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "hello 1")
        XCTAssertEqual(firstNote?.text, "text 1")
        
        XCTAssertEqual(secondNote?.title, "hello 2")
        XCTAssertEqual(secondNote?.text, "text 2")
        XCTAssertEqual(sut.notes.count, 2, "there should be 2 note in DB")
    }
    
    func testUpdateNote() {
        // given
        sut.createNoteWith(title: "hello 1", text: "text 1")
        guard let note = sut.notes.first else {
            XCTFail()
            return 
        }
       
        sut.updateNote(identifier: note.identifier, newTitle: "test", newText: "text")
        sut.fetchAllNotes()
        
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sut.notes.first?.title, "test")
        XCTAssertEqual(sut.notes.first?.text, "text")
    }
    
    func testRemoveNote() {
        sut.createNoteWith(title: "note 1", text: "text 1")
        sut.createNoteWith(title: "note 2", text: "text 2")
        sut.createNoteWith(title: "note 3", text: "text 3")
        
        guard let note = sut.notes.last else {
            XCTFail()
            return 
        }
        
        sut.removeNoteWith(identifier: note.identifier)
        XCTAssertEqual(sut.notes.count, 2)
    }
    
    func testRemoveNoteInDatabaseShouldThrowError() {
        sut.removeNoteWith(identifier: UUID())
        XCTAssertEqual(sut.databaseError, DatabaseError.errorRemove)
    }
}
