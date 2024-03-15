//
//  AsyncPublisherBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/15/24.
//

import SwiftUI
import Combine

class AsyncPublisherDataManager {
    @Published var myData: [String] = []
    
    func addData() async {
        myData.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon2")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon3")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon22")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon11")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon123")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon41")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        myData.append("watermelon123")
        
    }
}


class AsyncPublisherBootcampVM: ObservableObject {
    let manager = AsyncPublisherDataManager()
    var cancellables = Set<AnyCancellable>()
    @MainActor @Published var dataArray: [String] = []
    
    init() {
        addSubscribers()
    }
    
    // this is to subscribe to the @Published var myData:
    // how can I subscribe to the publisher without using combine pipeline ? concurrency way to do it 
    private func addSubscribers() {
        // this is asynchronous publisher
        Task {
            for await value in manager.$myData.values {
                await MainActor.run {
                    self.dataArray = value                    
                }
            }            
        }
//        
//        manager.$myData
//            .receive(on: DispatchQueue.main)
//            .sink { dataArray in
//                self.dataArray = dataArray
//            }
//            .store(in: &cancellables)

    }
    
    func start() async {
        await manager.addData()
    }
}

struct AsyncPublisherBootcamp: View {
    @StateObject private var viewModel = AsyncPublisherBootcampVM()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    AsyncPublisherBootcamp()
}
