//
//  DependencyInjectionBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/30/24.
//

import SwiftUI
import Combine

/* PROBLEMS WITH SINGLETON
 1. singletons are global
 2. could produce data races. 
 3. Can't swap out service ( dependencies )
// depency injection is an alternative or solution to using singletons
*/

struct PosticsModel: Identifiable, Codable {
    let userId, id: Int
    let title, body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PosticsModel], Error>
}

class MockDataService: DataServiceProtocol {
//    let testData: [PosticsModel] = [
//        PosticsModel(userId: 1, id: 1, title: "one", body: "one"),
//        PosticsModel(userId: 2, id: 21, title: "2one", body: "2one"),
//        PosticsModel(userId: 3, id: 31, title: "3one", body: "3one")
//    ]
    
    let testData: [PosticsModel]
    
    init(testData: [PosticsModel]?) {
        self.testData = testData ?? 
        [
            PosticsModel(userId: 1, id: 1, title: "one", body: "one"),
            PosticsModel(userId: 2, id: 21, title: "2one", body: "2one"),
            PosticsModel(userId: 3, id: 31, title: "3one", body: "3one")
        ]  
    }
    func getData() -> AnyPublisher<[PosticsModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

class ProductionDataService: DataServiceProtocol {
//    static let instance = productionDataService() // singleton
    let url: URL

    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PosticsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                print("Data from service: 🔥 \(String(describing: String(data: data, encoding: .utf8)))")
                return data
            }
            .decode(type: [PosticsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// Singleton example
//class productionDataService {
//    static let instance = productionDataService() // singleton
//    let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//    func getData() -> AnyPublisher<[PosticsModel], Error> {
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map ({ data, response in
//                print("Data from service: 🔥 \(String(describing: String(data: data, encoding: .utf8)))")
//                return data
//            })
//            .decode(type: [PosticsModel].self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//}

class DependencyInjectionBootcampVM: ObservableObject {
    @Published var dataArray: [PosticsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPost()
    }
    
    func loadPost() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] postArray in
                self?.dataArray = postArray
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    @StateObject private var vm: DependencyInjectionBootcampVM
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionBootcampVM(dataService: dataService))
    }
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { item in
                    Text(item.title)
                }
            }
        }
    }
}

#Preview {
    // this is a mock of initializing a dependency from a parent view 
    let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    let mockDataService = MockDataService(testData: [
        PosticsModel(userId: 1, id: 2, title: "22", body: "22")
    ])
    return DependencyInjectionBootcamp(dataService: mockDataService)
}
