//
//  SearchGame.swift
//  GameStream
//
//  Created by Sebastian on 19/04/22.
//

import Foundation

class SearchGame: ObservableObject {
    @Published var gameInfo = [Game]()
    
    func search(gameName: String){
        
        gameInfo.removeAll()
        let gameNameQuery = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games/search?contains=\(gameNameQuery ?? "cuphead")")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let jsonData = data {
                    print("Json size: \(jsonData) ")
                    
                    let decodedData = try JSONDecoder().decode(GameResult.self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.gameInfo.append(contentsOf: decodedData.results)
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                print("Error: \(error)")
                
            }
        }.resume()
    }
    
}
