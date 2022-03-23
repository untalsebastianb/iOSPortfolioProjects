//
//  NetworkingClient.swift
//  PragmaticWrittenApp
//
//  Created by Sebastian on 23/03/22.
//

import Foundation

class NetworkClient {
    
    let baseURL: URL
    let session: URLSession
    
    static let shared = NetworkClient(baseURL: URL(string: "https://pokeapi.co/api/v2/")!, session: .shared)
    
    init(baseURL: URL, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func getPost(completion: @escaping (PostResponseModel?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: "pokemon", relativeTo: baseURL)
        let task = session.dataTask(with: url!) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    error == nil,
                    let data = data
                    else {
                        print(" an error occured")
                        completion(nil, error)
                        return
                    }
            let decoder = JSONDecoder()
            
            do {
                let post = try decoder.decode(PostResponseModel.self, from: data)
                completion(post, nil)
            } catch {
                print("error parsing the data", error)
                completion(nil, error)
            }
            
        }
        task.resume()
        return task
    }
     
}
