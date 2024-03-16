//
//  StrongSelfBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/15/24.
//


/*
 this is asinchronous context and the function is called async 
 func updateData() async {
         data = await manager.getData() 
 }
 
 .task {
     await viewModel.updateData()
 }
 
 
 to use this function is not async and has a task inside for asynchronous context
 func updateData()  {
    Task {
        data = await manager.getData() 
    }
 }
 .onAppear{
     await viewModel.updateData()
 }
 
 */

import SwiftUI

final class StrongSelfDataService {
    func getData() async -> String {
        "update data"
    }
}

final class StrongSelfBootcampViewModel: ObservableObject {
    @Published var data: String = "Some Title!"
    let manager = StrongSelfDataService()
    
    private var someTask: Task<Void, Never>? = nil
    private var myTask: [Task<Void, Never>] = []
    
    func cancelTasks() {
        someTask?.cancel()
        someTask = nil
        
        myTask.forEach { $0.cancel() }
        myTask = []
    }
    
    deinit {
        print("is gone 🔥")
    }
    
    // this implies strong reference...
    func updateData() async {
            data = await manager.getData() 
    }
    
    func updateData2() async {
        self.data = await manager.getData() 
    }
    
    func updateData3() {
        Task { [self] in
            self.data = await manager.getData()             
        }
    }
    
    // we don't need  manage weak/Strong
    // we can manage the Task!
    func updateData4() {
        someTask =  Task { 
            self.data = await manager.getData()         
        }
    }
    
    func updateData5() {
        Task { [weak self] in
            if let data = await self?.manager.getData() {
                self?.data = data
            }             
        }
    }
    
    func updateData6() {
        let task1 = Task {
            data = await manager.getData()
        }
        
        myTask.append(task1)
        
        let task2 = Task {
            data = await manager.getData()
        }
        
        myTask.append(task2)
    }
    
    // purposely do not cancel task to keep strong references
    func updateData7() {
        Task {
            self.data = await manager.getData()             
        }
        Task.detached { 
            self.data = await self.manager.getData()      
        }
    }
}

struct StrongSelfBootcamp: View {
    @StateObject private var viewModel = StrongSelfBootcampViewModel()
    
    var body: some View {
        Text(viewModel.data)
            .onAppear {
                viewModel.updateData4()                 
            }
            .onDisappear{
                viewModel.cancelTasks()
            }
            .task {
                await viewModel.updateData()
            }
    }
}

#Preview {
    StrongSelfBootcamp()
}
