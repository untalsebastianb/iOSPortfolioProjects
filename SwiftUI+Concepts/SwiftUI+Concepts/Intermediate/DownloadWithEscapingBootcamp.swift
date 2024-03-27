//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUI+Concepts
//
//  Created by Juan Sebastian Bueno on 3/26/24.
//

import SwiftUI

// fake API 🔥 https://jsonplaceholder.typicode.com/

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

// code to download data
/*
 URLSession.shared.dataTask(with: url) { data, response, error in
     guard let data = data,
           error == nil,
           let response = response as? HTTPURLResponse,
           response.statusCode >= 200 && response.statusCode <= 300 else {
         print("no data")
         return
     }
     
     print("Succesfully downloaded 📊")
     print("JSon string data: -> \(String(describing: String(data: data, encoding: .utf8)))")
     
     guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
     print("---> \(newPost)")
     // here we are in BG thread
     DispatchQueue.main.async { [weak self] in
         self?.posts.append(newPost)
     }

 }.resume()
 */

// MARK: - PostModel
struct PostModel: Identifiable, Codable {
    let userId, id: Int
    let title, body: String
}


class DownloadWithEscapingBootcampVM: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return } 
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("no data returned")
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode <= 300 else {
                print("no data")
                completionHandler(nil)
                return
            }
            
            print("Succesfully downloaded 📊")
            print("JSon string data: -> \(String(describing: String(data: data, encoding: .utf8)))")
            
            completionHandler(data)
            
        }.resume()
    } 
}

struct DownloadWithEscapingBootcamp: View {
    @StateObject private var vm = DownloadWithEscapingBootcampVM()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadWithEscapingBootcamp()
}
