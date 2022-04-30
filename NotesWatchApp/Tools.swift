//
//  Tools.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import Foundation

class Tools {
    let key = "NotesApp"
    
    static let shared = Tools()
    
    private init(){ }
    
    func save(notes: [Note]) {
        let data = notes.map{ try? JSONEncoder().encode($0) }
    
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func load() -> [Note] {
        guard let savedData = UserDefaults.standard.array(forKey: key) as? [Data] else { return [] }
        return savedData.map{ try! JSONDecoder().decode(Note.self, from: $0)}
    }

}
