//
//  ContextMenuBt.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/24/24.
//

import SwiftUI

struct ContextMenuBt: View {
    @State var backgroundColor: Color = .gray
    var body: some View {
        VStack(alignment: .leading, spacing: 10) { 
            Image(systemName: "house.fill")
                .font(.title)
            Text("Juancho iOS Developer")
                .font(.headline)
            Text("Using ContextMenu")
                .font(.subheadline)
        }
        .padding()
        .background(backgroundColor.cornerRadius(10).opacity(0.5))
        .contextMenu(menuItems: {
            Button(action: {backgroundColor = .cyan}, label: {
                Label("Share", systemImage: "square.and.arrow.up")
            })
            Button(action: {backgroundColor = .red}, label: {
                Label("Delete", systemImage: "trash")
            })
            Button(action: {backgroundColor = .yellow}, label: {
                Label("Copy", systemImage: "doc.on.doc")
            })
            Button(action: {backgroundColor = .indigo}, label: {
                Label("Back", systemImage: "arrowshape.backward.circle")
            })
        })
    }
}

#Preview {
    ContextMenuBt()
}
