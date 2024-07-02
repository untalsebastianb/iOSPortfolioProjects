//
//  ContentView.swift
//  ToDoTestApp
//
//  Created by Juan Sebastian Bueno on 6/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var vm: ViewModel = ViewModel()
    @State var showCreateNote = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.notes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading, content: {
                            Text(note.title)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .foregroundStyle(.secondary)
                        })
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .status, content: {
                    Button(action: {
                        showCreateNote = true
                    }, label: {
                        Label("Create", systemImage: "plus")
                            .labelStyle(.iconOnly)
                    })
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                })
            })
            .navigationTitle("Notes")
            .navigationDestination(for: Note.self, destination: { note in
                UpdateNoteView(viewModel: vm, identifier: note.identifier, title: note.title, text: note.getText)
            })
            .fullScreenCover(isPresented: $showCreateNote, content: {
                CreateNoteView(viewModel: vm)
            })
        }
    }
}

#Preview {
    ContentView(vm: .init(notes: [
        .init(title: "TestApp", text: "Text", createdAt: .now),
        .init(title: "Testing", text: "Text", createdAt: .now)
    ]))
}
