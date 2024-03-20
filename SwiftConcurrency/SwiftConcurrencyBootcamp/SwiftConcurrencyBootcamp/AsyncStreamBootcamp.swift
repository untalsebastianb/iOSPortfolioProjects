//
//  AsyncStreamBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Juan Sebastian Bueno on 3/19/24.
//

import SwiftUI

class AsyncStreamDataManager {
    
    @Published private(set) var itemsInt: [Int] = []
    
    // TODO: take this and do it with asyncPublisher
    func getFakeData() async {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                self.itemsInt.append(item)
                print("NEW DATA: \(item)")
            })
        }
    }
    
    // wrap completion handler inside a stream
    func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
        AsyncThrowingStream(Int.self) { [weak self] continuation in
            self?.getDakeData { value in
                continuation.yield(value)
            } onFinish: { error in
                if let error {
                    continuation.finish(throwing: error)
                } else {
                    continuation.finish()                    
                }
            }
        }
    }
    
    // we are taking completion handler and turn it into an asynchronous function that returns data
    func getDakeData(
        completion: @escaping (_ value: Int) -> (),
        onFinish: @escaping (_ error: Error?) -> ())  {
        let items: [Int] = [1,2,3,4,5,6,7,8,9,10]
        for item in items {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(item), execute: {
                completion(item)
                print("NEW DATA: \(item)")
                
                if item == items.last {
                    onFinish(nil)
                }
            })
        }
    }
}

@MainActor
final class AsyncStreamBootcampViewModel: ObservableObject {
    let manager = AsyncStreamDataManager()
    @Published private(set) var currentNumber: Int = 0
    
    @Published private(set) var itemsInt: [Int] = []
    
    init() {
        addSubscribers()
    }
    
    
    func onViewAppear() {
        // if i cancel this task I'm not cancelling the stream
        let task = Task {
            do {
                // here you can do operators from combine
                for try await value in manager.getAsyncStream().dropFirst(2) {
                    currentNumber = value
                }
            }catch {
                print(error)
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//            task.cancel()
//            print("TASK CANCELED")
//        })
    }
    
    func addSubscribers() {
        // using AsyncPublisher
        Task {
            // here you can do operators from combine
            for await value in manager.$itemsInt.values {
                print("VALUE: \(value)")
                itemsInt = value
            }        }
    }
    
    func startFetching() async {
        await manager.getFakeData()
    }
}

struct AsyncStreamBootcamp: View {
    
    @StateObject private var viewModel = AsyncStreamBootcampViewModel()
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach(viewModel.itemsInt, id: \.self) { numero in
                    Text("\(numero) pepepe")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
        }
        .task {
            await viewModel.startFetching()
        }
//        Text("\(viewModel.currentNumber)")
//            .onAppear{
//                viewModel.onViewAppear()
//            }
    }
}

#Preview {
    AsyncStreamBootcamp()
}
