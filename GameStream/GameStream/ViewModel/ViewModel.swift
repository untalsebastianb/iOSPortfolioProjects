//
//  ViewModel.swift
//  GameStream
//
//  Created by Sebastian on 14/04/22.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
     
    @Published var gamesInfo = [Game]()
    
    init() {
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let jsonData = data {
                    print("Json size: \(jsonData) ")
                    
                    let decodedData = try JSONDecoder().decode([Game].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.gamesInfo.append(contentsOf: decodedData)
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                print("Error: \(error)")

            }
        }.resume()
    }
}
