//
//  NoteDetail.swift
//  NotesWatchApp WatchKit Extension
//
//  Created by Sebastian on 29/04/22.
//

import SwiftUI

struct NoteDetail: View {
    
    let note: Note
    
    var body: some View {
        VStack {
            Text(note.title)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .padding()
            Text(note.creationDate)
                .font(.system(size: 12))
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 3.0))
        }
       
    }
}

struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetail(note: Note(title: "Example"))
    }
}
