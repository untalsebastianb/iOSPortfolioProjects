//
//  CombineBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 9/9/24.
//

import SwiftUI
import Combine

struct PostModelCombine: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadCombineViewModel : ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    init() {
        getPost()
    }
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300  else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                print("completion \(completion)")
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let failure):
                    print("there was an error \(failure)")
                }
            }, receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)


    }
}

struct CombineBootcamp: View {
    @StateObject var vmDownload = DownloadCombineViewModel()
    var body: some View {
        List { 
            ForEach(vmDownload.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    CombineBootcamp()
}
