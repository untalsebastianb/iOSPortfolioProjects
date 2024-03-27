//
//  DownloadWithCombine.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/27/24.
//

import SwiftUI

// 1. sign up for monthly subscription for package to be delivered
// 2. the complany would make the package behind the scenes
// 3. reveive the package in your front door
// 4. make sure the box isn't damaged
// 5. open and make sure the item is correct
// 6. use the item
// 7. cancellable at any time!


// 1. create the publisher URLSession.shared.dataTaskPublisher(for: url)
// 2. subscribe the publisher on background thread -> this is done automatically 
//    .subscribe(on: DispatchQueue.global(qos: .background))
// 3. receive on main thread .receive(on: DispatchQueue.main)
// 4. tryMap (check the data is good) .tryMap { data, response -> Data in
//guard let response = response as? HTTPURLResponse, 
//        response.statusCode >= 200 && response.statusCode < 300 else {
//    throw URLError(.badServerResponse)
//}
//return data
//}
// 5. decode data into postModels 
//    .decode(type: [PostModel1].self, decoder: JSONDecoder())
// 6. sink (put the item into our app)
//    .sink { completion in
//        // this is call when the completion is finish, you can see here the errors!
//        print("Completion --> \(completion)")
//    } receiveValue: { [weak self] returnedPost in
//        self?.posts = returnedPost
//    }
// 7. store ( cancel subscription if needed )
//    .store(in: &cancellabes)


/*
 
 here is an example of returning the publisher and calling it from the view
 import SwiftUI
 import Combine

 struct PostModel1: Codable {
     let userId: Int
     let id: Int
     let title: String
     let body: String
 }

 class ViewModel: ObservableObject {
     @Published var posts: [PostModel1] = []
     private var cancellables = Set<AnyCancellable>()
     
     func getPost() -> AnyPublisher<[PostModel1], Error> {
         guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
             return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
         }
         
         return URLSession.shared.dataTaskPublisher(for: url)
             .mapError { $0 as Error }
             .map { $0.data }
             .decode(type: [PostModel1].self, decoder: JSONDecoder())
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
     }
 }

 struct ContentView: View {
     @StateObject private var viewModel = ViewModel()
     
     var body: some View {
         VStack {
             Button("Fetch Posts") {
                 viewModel.getPost()
                     .sink(receiveCompletion: { completion in
                         switch completion {
                         case .finished:
                             print("Fetching posts completed.")
                         case .failure(let error):
                             print("Error fetching posts: \(error)")
                         }
                     }, receiveValue: { [weak self] posts in
                         self?.viewModel.posts = posts
                     })
                     .store(in: &viewModel.cancellables)
             }
             
             List(viewModel.posts, id: \.id) { post in
                 VStack(alignment: .leading) {
                     Text(post.title)
                         .font(.headline)
                     Text(post.body)
                         .foregroundColor(.gray)
                 }
             }
         }
         .padding()
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }

 
 */

// MARK: - PostModel
struct PostModel1: Identifiable, Codable {
    let userId, id: Int
    let title, body: String
}

import Combine

class DownloadWithCombineVM: ObservableObject {
    @Published var posts: [PostModel1] = []
    var cancellabes = Set<AnyCancellable>()
    
    init() {
        getPost()
    }
    
    func getPost() {
        
        // 1. create the publisher URLSession.shared.dataTaskPublisher(for: url)
        // 2. subscribe the publisher on background thread -> this is done automatically 
        //    .subscribe(on: DispatchQueue.global(qos: .background))
        // 3. receive on main thread
        // 4. tryMap (check the data is good)
        // 5. decode data into postModels
        // 6. sink (put the item into our app)
        // 7. store ( cancel subscription if needed )
        
        /*
         if you dont want to deal with errors use
         
         .replaceError(with: [])
         .sink( receiveValue: { [weak self] returnedPost in
             self?.posts = returnedPost
         })
         */
        
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, 
                        response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel1].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    // show an alert to thandle this error // @State
                    print("there was an error")
                }
                // this is call when the completion is finish, you can see here the errors!
                print("Completion --> \(completion)")
            } receiveValue: { [weak self] returnedPost in
                self?.posts = returnedPost
            }
            .store(in: &cancellabes)
    }
}

struct DownloadWithCombine: View {
    @StateObject var vm = DownloadWithCombineVM()
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}
