//
//  Note.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct Note: Identifiable {
    var id: UUID
    
    var title: String
    var creationDate: String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        
        let date = Date()
        let dateFormateer = DateFormatter()
        dateFormateer.dateStyle = .long
        dateFormateer.timeStyle = .medium
        
        self.creationDate = dateFormateer.string(from: date)
        
    }
    
}
