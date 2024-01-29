//
//  TaskBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 1/16/24.
//

import SwiftUI


class TaskBootcampViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    var fetchImageTask: Task<(), Never>? = nil // this is the way of doing it from vm 
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        
        // TASK Could still running after cancelation, to prevent that you need to 
        try? Task.checkCancellation()
        
        do {
            guard let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM") else { return }
            let (data, response) = try await URLSession.shared.data(from: url)
            await MainActor.run { 
                let image = UIImage(data: data)
                self.image = image
                print("Image returned succesfully")
            }
            
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://fastly.picsum.photos/id/829/200/200.jpg?hmac=UR6WfoHy282eoIXjFzEm86pUeBNLQsX71BUthF-sOvM") else { return }
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let image = UIImage(data: data)
            self.image2 = image
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
}


struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Click Me!", destination: TaskBootcamp())
            }
        }
    }
}

struct TaskBootcamp: View {
    @StateObject private var viewModel = TaskBootcampViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil // this is the way of doing it from view
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            if let image2 = viewModel.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
        .onDisappear {
            viewModel.fetchImageTask?.cancel()
        }
//        .onAppear {  // this is synchronous code
//            self.viewModel.fetchImageTask = Task { // this is asynchronous code
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetchImage()
//             await viewModel.fetchImage2() // -> this cannot run until everything before has completed to that we use concurrency!
//            }
//            Task { // this is asynchronous code
//                print(Thread.current)
//                print(Task.currentPriority)
//                await viewModel.fetchImage2()
//            }
//            Task(priority: .high) { 
////                try? await Task.sleep(nanoseconds: 2_000_000_000)
//                await Task.yield() // let other task to go first
//                print("high: \(Thread.current) : \(Task.currentPriority)")
//            }
//            
//            Task(priority: .userInitiated) { 
//                print("userInitiated: \(Thread.current) : \(Task.currentPriority)")
//            }
//            
//            Task(priority: .medium) { 
//                print("MEDIUM: \(Thread.current) : \(Task.currentPriority)")
//            }
//            
//            Task(priority: .low) { 
//                print("LOW: \(Thread.current) : \(Task.currentPriority)")
//            }
//                        
//            Task(priority: .background) { 
//                print("background: \(Thread.current) : \(Task.currentPriority)")
//            }
//            
//            Task(priority: .utility) { 
//                print("utility: \(Thread.current) : \(Task.currentPriority)")
//            }
            
            // in this case both of this task have the same priority
            // child task inherit from parent
//            Task(priority: .userInitiated) { 
//                print("userInitiated: \(Thread.current) : \(Task.currentPriority)")
//                
//                Task.detached { // we detached the're not gonna have the same priority
//                    print("detached: \(Thread.current) : \(Task.currentPriority)")
//                }
//            } 
        }
    }
//}

#Preview {
    TaskBootcamp()
}
