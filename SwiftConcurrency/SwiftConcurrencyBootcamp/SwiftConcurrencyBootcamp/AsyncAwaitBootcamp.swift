//
//  AsyncAwaitBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 1/9/24.
//

import SwiftUI

class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title1: \(Thread.current)")            
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title2: \(Thread.current)"    
            DispatchQueue.main.async {
                self.dataArray.append(title)
                let title = "Title3: \(Thread.current)"   
                self.dataArray.append(title)
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author1: \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        await doSomething()
        let author2 =  "Author2: \(Thread.current)"
        
        await MainActor.run { 
            self.dataArray.append(author2)
            let author3 =  "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        }
        
        await addSomething()
    }
    
    func doSomething() async {
        print("Hi")
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 =  "something1: \(Thread.current)"
        
        await MainActor.run { 
            self.dataArray.append(something1)
            let something2 =  "something2: \(Thread.current)"
            self.dataArray.append(something2)
        }
    }
    
}

struct AsyncAwaitBootcamp: View {
    @StateObject private var viewModel = AsyncAwaitBootcampViewModel()
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            Task {
                await viewModel.addAuthor1()
                await viewModel.addSomething()
                let final = "Final Text \(Thread.current)"
                viewModel.dataArray.append(final)
            }
//            viewModel.addTitle1()
//            viewModel.addTitle2()
        }
    }
}

#Preview {
    AsyncAwaitBootcamp()
}
