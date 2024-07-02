//
//  Mocks.swift
//  ToDoTestAppTests
//
//  Created by Juan Sebastian Bueno on 7/1/24.
//

import Foundation
@testable import ToDoTestApp

class MockUseCaseContainer {
    var mockDatabase: [Note] = []

    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
    }

    func fetchAll() throws -> [Note] {
        return mockDatabase
    }

    func removeNoteWith(identifier: UUID) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase.remove(at: index)
        }
    }

    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
}

extension MockUseCaseContainer: CreateNoteProtocol, FetchAllNotesProtocol, RemoveNoteProtocol, UpdateNotesProtocol {}



//var mockDatabase: [Note] = []

//struct CreateNoteUseCaseMock : CreateNoteProtocol {
//    func createNoteWith(title: String, text: String) throws {
//        let note: Note = .init(title: title, text: text, createdAt: .now)
//        mockDatabase.append(note)
//    }
//}
//
//struct FetchAllNotesUseCaseMock : FetchAllNotesProtocol {
//    func fetchAll() throws -> [ToDoTestApp.Note] {
//        return mockDatabase
//    }
//}
//
//struct RemoveNoteUseCaseMock: RemoveNoteProtocol {
//    func removeNoteWith(identifier: UUID) throws {
//        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
//            mockDatabase.remove(at: index)
//        }
//    }
//}
//
//struct UpdateNoteUseCaseMock: UpdateNotesProtocol {
//    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
//        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
//            mockDatabase[index].title = title
//            mockDatabase[index].text = text
//        }
//    }
//}
