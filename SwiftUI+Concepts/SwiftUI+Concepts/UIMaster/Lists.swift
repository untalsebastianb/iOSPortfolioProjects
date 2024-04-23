//
//  Lists.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 4/23/24.
//

import SwiftUI

struct Lists: View {
    @State var fruits: [String] = [
        "apple", "orange", "banana", "peach"
    ] 
    @State var fruit = ""
    @State var showAddFruit: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section("Fruits") { 
                    ForEach(fruits, id: \.self) { fruit in
                        HStack {
                            Spacer()
                            Text(fruit.capitalized)
                            Spacer()
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .listRowBackground(Color.gray)
                }
            }
            .navigationTitle("Grocery List")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) { 
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) { 
                    Button("Add", action: {
                        showAddFruit.toggle()
                    })
                }
                
//                ToolbarItem(placement: .topBarTrailing) { 
//                    Button("Add", action: add)
//                }
            })
            .alert("Add Fruit", isPresented: $showAddFruit) {
                TextField("Fruit", text: $fruit)
                Button("Cancel", role: .cancel) {}
                Button("Add") { 
                    withAnimation { 
                        fruits.append(fruit)
                    }
                }
            }
        }
        .accentColor(.red)
    }
    
    func add() {
        withAnimation { 
            fruits.append("Coconut")
        }
    }
    
    func move(indices: IndexSet, newOffset: Int) {
        fruits.move(fromOffsets: indices, toOffset: newOffset)
    }
    
    func delete(index: IndexSet) {
        fruits.remove(atOffsets: index)
    }
}

#Preview {
    Lists()
}
