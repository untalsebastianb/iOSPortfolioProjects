//
//  CreateNoteView.swift
//  ToDoTestApp
//
//  Created by Juan Sebastian Bueno on 6/9/24.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: ViewModel
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("*Text"), axis: .vertical)
                } footer: {
                    Text("* Title is mandatory")
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) { 
                    Button(action: { dismiss() }, label: {
                        Text("Close")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) { 
                    Button(action: {
                        viewModel.createNoteWith(title: title, text: text)
                        dismiss()
                    }, label: {
                        Text("Create Note")
                            .bold()
                    })
                }
            })
            .navigationTitle("Create Note")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
