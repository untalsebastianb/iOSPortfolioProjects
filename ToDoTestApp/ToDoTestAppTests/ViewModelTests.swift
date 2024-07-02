//
//  ViewModelTests.swift
//  ToDoTestAppTests
//
//  Created by Juan Sebastian Bueno on 6/26/24.
//

import XCTest
@testable import ToDoTestApp


final class ViewModelTests: XCTestCase {
    var viewModel: ViewModel!
    var mockUseCaseContainer: MockUseCaseContainer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockUseCaseContainer = MockUseCaseContainer()
        viewModel = ViewModel(createNoteUseCase: mockUseCaseContainer,
                              fetchAllNotesUseCase: mockUseCaseContainer,
                              updateNoteUseCase: mockUseCaseContainer,
                              removeNoteUseCase: mockUseCaseContainer)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockUseCaseContainer.mockDatabase = []
    }
    
    func testCreateNote() {
        // given
        let title = "Test Title"
        let text = "Test Text"
        
        // when
        viewModel.createNoteWith(title: title, text: text)
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.text, text)
        XCTAssertEqual(viewModel.notes.first?.title, title)
    }
    
    
    func testUpdateNote() {
        // given
        let title = "Test Title"
        let text = "Test Text"
        
        viewModel.createNoteWith(title: title, text: text)
        
        let newTitle = "New Title"
        let newText = "New Text"
        
        // when
        if let id = viewModel.notes.first?.identifier {
            viewModel.updateNote(identifier: id, newTitle: newTitle, newText: newText)
            // Then
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
        } else {
            XCTFail("No note was created")
        }
    }
    
    func testRemoveNote() {
        // given
        let title = "Test Title"
        let text = "Test Text"

        XCTAssertEqual(viewModel.notes.count, 0) // Verificar que inicialmente no hay notas
        
        viewModel.createNoteWith(title: title, text: text)
        XCTAssertEqual(viewModel.notes.count, 1) // Verificar que se ha creado una nota

        if let id = viewModel.notes.first?.identifier {
            // when
            viewModel.removeNoteWith(identifier: id)
            
            // then
            XCTAssertEqual(viewModel.notes.count, 0) // Verificar que la nota ha sido eliminada
            XCTAssertTrue(viewModel.notes.isEmpty)
        }
        
    }


}
