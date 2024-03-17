//
//  MVVMBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/16/24.
//

import SwiftUI

actor MyManagerActor {
    
    func getData() async throws -> String {
        "Some Data!"
    }
}

class MyManagerClass {
    func getData() async throws -> String {
        "Some Data!"
    }
}

@MainActor
final class MVVMBootcampViewModel: ObservableObject {
    
    
    private let managerClass = MyManagerClass()
    private let managerActor = MyManagerActor()
    
    // if you marked this to the main actor, one way to solve is to mark entire class 
    // as @MainActor or Task as @MainActor in
    @MainActor @Published private(set) var myData: String = "Starting Text"
    private var tasks: [Task<Void, Never>] = []
    
    func cancelTasks() {
        tasks.forEach { 
            $0.cancel()
        }
        tasks = []
    }
    
    func onCallToActionButtonPressed() {
        // this is to create the asynchronous here and not in the view
        let task = Task {
            do {
//                myData = try await managerClass.getData()
                // this is doing switches from actor from managerActor to MainActor
                myData = try await managerActor.getData()
            } catch {
                print(error)
            }
        }
        tasks.append(task)
    }
    
}



struct MVVMBootcamp: View {
    
    @StateObject private var viewModel = MVVMBootcampViewModel()
    var body: some View {
        VStack {
            Button(viewModel.myData) {
                viewModel.onCallToActionButtonPressed()
            }            
        }
        .onDisappear {
            viewModel.cancelTasks()
        }
    }
}

#Preview {
    MVVMBootcamp()
}
