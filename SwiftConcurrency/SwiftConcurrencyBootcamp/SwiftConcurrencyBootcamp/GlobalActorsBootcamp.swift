//
//  GlobalActors.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/15/24.
//

import SwiftUI


@globalActor struct MyFirstGlobalActor {
    static var shared = MyDataNewManager()    
}

actor MyDataNewManager {
    
    func getDataFromDB() -> [String] {
        return ["one", "Two", "Three", "Four"]
    }
}


// you can also mark the entire class to MainActor
//@MainActor
class GlobalActorsBootcampViewModel: ObservableObject {
    
    let manager = MyFirstGlobalActor.shared
    // declared @MainActor to isolated this to the main thread, to make xcode give us warnings
    @MainActor @Published var dataArray: [String] = []
    
    @MyFirstGlobalActor
    func getData() {
        Task {
            let data = await manager.getDataFromDB()
            // Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
            // to solve this you can call the await MainActor.run {} or  DispatchQueue.main.async {
//            await MainActor.run { 
            DispatchQueue.main.async {
                self.dataArray = data            
            }
//            }
        }
    }
    
    @MainActor
    func getDataMain() async {
        let data = await manager.getDataFromDB()
        self.dataArray = data
    }
    
    
}

struct GlobalActors: View {
    @StateObject private var viewModel = GlobalActorsBootcampViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
            .task {
               await viewModel.getData()
            }
        }
    }
}

#Preview {
    GlobalActors()
}
