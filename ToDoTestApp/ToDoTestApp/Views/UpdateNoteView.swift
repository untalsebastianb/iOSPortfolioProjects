//
//  UpdateNoteView.swift
//  ToDoTestApp
//
//  Created by Juan Sebastian Bueno on 6/10/24.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    let id: UUID
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Text"), axis: .vertical)
                }
            }
            Button(action: {
                viewModel.removeNoteWith(id: id)
                dismiss()
            }, label: {
                Text("Delete note")
                    .foregroundStyle(.gray)
                    .underline()
            })
            .buttonStyle(.borderless)
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) { 
                Button(action: {
                    viewModel.updateNote(id: id, newTitle: title, newText: text)
                    dismiss()
                }, label: {
                    Text("Save")
                        .bold()
                })
            }
        })
        .navigationTitle("Update Note")
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), id: .init(), title: "Test")        
    }
}
