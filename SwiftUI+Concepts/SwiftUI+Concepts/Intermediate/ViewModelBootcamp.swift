//
//  ViewModelBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 9/5/24.
//

import SwiftUI

class FruitViewModel: ObservableObject {
    @Published var fruitArray: [FruitModel] = []
    @Published var isLoading: Bool = false
    
    init() {
        getFruits()
    }
    
    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
    
    func getFruits() {
        let fruit1: FruitModel = .init(name: "Orange", count: 1)
        let fruit2: FruitModel = .init(name: "Banana", count: 20)
        let fruit3: FruitModel = .init(name: "Pineaple", count: 7)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.fruitArray.append(fruit1)
            self.fruitArray.append(fruit2)
            self.fruitArray.append(fruit3)  
            self.isLoading = false
        })
    }

}

struct FruitModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let count: Int
}

struct ViewModelBootcamp: View {
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    var body: some View {
        NavigationView { 
            List {
                if fruitViewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(fruitViewModel.fruitArray) { fruit in 
                        HStack { 
                            Text("\(fruit.count)")
                                .foregroundStyle(.red)
                            Text(fruit.name)
                                .font(.headline)
                        }
                    }
                    .onDelete(perform: fruitViewModel.deleteFruit)                    
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Fruit list")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing, content: {
                    NavigationLink { 
                        SecondScreenView(fruitViewModel: fruitViewModel)
                    } label: { 
                        Image(systemName: "arrow.right")
                            .font(.title)
                    }

                })
            })
        }
    }
}

struct SecondScreenView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var fruitViewModel: FruitViewModel
    var body: some View {
        ZStack { 
            Color.green.ignoresSafeArea()
            VStack { 
                ForEach(fruitViewModel.fruitArray) { fruit in
                    Text(fruit.name)
                        .foregroundStyle(.white)
                        .font(.headline)
                }
                Button(action: {
                    dismiss()
                }) { 
                    Text("go Back")
                }
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    ViewModelBootcamp()
//    SecondScreenView()
}
