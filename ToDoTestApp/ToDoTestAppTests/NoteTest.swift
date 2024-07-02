//
//  ToDoTestAppTests.swift
//  ToDoTestAppTests
//
//  Created by Juan Sebastian Bueno on 6/10/24.
//

import XCTest
@testable import ToDoTestApp


final class NoteTest: XCTestCase {
    
    func testNoteInitialization() {
        // Given pr Arrange
        let title = "Test title"
        let text = "Test test"
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: text, createdAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createdAt, date)
    }
    
    func testNoteEmptyText() {
        // Given pr Arrange
        let title = "Test title"
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: nil, createdAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.getText, "")
    }
}
