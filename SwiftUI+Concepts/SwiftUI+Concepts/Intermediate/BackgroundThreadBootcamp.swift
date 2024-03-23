//
//  BackgroundThreadBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/22/24.
//

import SwiftUI

class BackgroundThreadBootcampViewModel: ObservableObject {
    @Published private(set) var dataArray: [String] = []
    
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            print("Check1", Thread.isMainThread)
            print("Check1", Thread.current)
            // main thread
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check2", Thread.isMainThread)
                print("Check2", Thread.current)
            }
        }
        // background thread
//        DispatchQueue.global().async { 
//            let newData = self.downloadData()
//            // main thread
//            DispatchQueue.main.async {
//                self.dataArray = newData            
//            }
//        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 1..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadBootcampViewModel()
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10, content: {
                Text("Load data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                }
            })
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
