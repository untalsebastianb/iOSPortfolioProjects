//
//  ViewModel.swift
//  Ricky&Morty
//
//  Created by Juan Sebastian Bueno on 3/05/23.
//

import Foundation

struct characterModel: Decodable {
    let id: Int
    let name: String
    let image: String
    let episode: [String]
    let locationName: String
    let locationURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case episode
        case location
        case locationURL = "url"
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<characterModel.CodingKeys> = try decoder.container(keyedBy: characterModel.CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: characterModel.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: characterModel.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: characterModel.CodingKeys.image)
        self.episode = try container.decode([String].self, forKey: characterModel.CodingKeys.episode)

        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        self.locationName = try locationContainer.decode(String.self, forKey: .name)
        self.locationURL = try locationContainer.decode(String.self, forKey: .locationURL)

    }
}

final class ViewModel {
    func executeRequest() {
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!

        URLSession.shared.dataTask(with: characterURL) { data, response, error in
            let characterModel = try! JSONDecoder().decode(characterModel.self, from: data!)
            print("character model \(characterModel)")
        }.resume()

    }
}
