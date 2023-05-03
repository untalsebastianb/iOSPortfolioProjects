//
//  ViewModel.swift
//  Ricky&Morty
//
//  Created by Juan Sebastian Bueno on 3/05/23.
//

import Foundation

struct CharacterModel: Decodable {
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
        let container: KeyedDecodingContainer<CharacterModel.CodingKeys> = try decoder.container(keyedBy: CharacterModel.CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: CharacterModel.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CharacterModel.CodingKeys.name)
        self.image = try container.decode(String.self, forKey: CharacterModel.CodingKeys.image)
        self.episode = try container.decode([String].self, forKey: CharacterModel.CodingKeys.episode)

        let locationContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        self.locationName = try locationContainer.decode(String.self, forKey: .name)
        self.locationURL = try locationContainer.decode(String.self, forKey: .locationURL)

    }
}

struct EpisodeModel: Decodable {
    let id: Int
    let name: String
}

struct LocationModel: Decodable {
    let id: Int
    let name: String
    let dimension: String
}

struct CharacterBasicInfo {
    let name: String
    let image: URL?
    let fistEpisodeTitle: String
    let dimension: String

    static var empty: Self {
        .init(name: "", image: nil, fistEpisodeTitle: "", dimension: "")
    }
}

final class ViewModel: ObservableObject {

    @Published var characterBasicInfo: CharacterBasicInfo = .empty

    func executeRequestAsync() async {
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        let (data, _) = try! await URLSession.shared.data(from: characterURL)
        let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data)
        print("Character Model \(characterModel)")

        let firstEpisodeURL = URL(string: characterModel.episode.first!)!
        let (dataFirstEpisode, _) = try! await URLSession.shared.data(from: firstEpisodeURL)
        let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: dataFirstEpisode)
        print("Episode Model \(episodeModel)")

        let characterLocationURL = URL(string: characterModel.locationURL)!
        let (dataLocation, _) = try! await URLSession.shared.data(from: characterLocationURL)
        let locationModel = try! JSONDecoder().decode(LocationModel.self, from: dataLocation)
        print("Location Model \(locationModel)")

        DispatchQueue.main.async {
            self.characterBasicInfo = .init(name: characterModel.name,
                                            image: URL(string: characterModel.image)!,
                                            fistEpisodeTitle: episodeModel.name,
                                            dimension: locationModel.dimension)
        }
    }


    func executeRequestCallback() {

//        First call
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        URLSession.shared.dataTask(with: characterURL) { data, response, error in
            let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data!)
            print("character model \(characterModel)")

//            Create 2nd call with data from 1st
            let firstEpisodeURL = URL(string: characterModel.episode.first!)!
            URLSession.shared.dataTask(with: firstEpisodeURL) { data, response, error in
                let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: data!)
                print("Episode Model \(episodeModel)")

//                3rd call
                let characterLocationURL = URL(string: characterModel.locationURL)!

                URLSession.shared.dataTask(with: characterLocationURL) { data, error, response in
                    let locationModel =  try! JSONDecoder().decode(LocationModel.self, from: data!)
                    print("Location Model \(locationModel)")
                    DispatchQueue.main.async {
                        self.characterBasicInfo = .init(name: characterModel.name,
                                                        image: URL(string: characterModel.image)!,
                                                        fistEpisodeTitle: episodeModel.name,
                                                        dimension: locationModel.dimension)
                    }
                }.resume()

            }.resume()

        }.resume()

    }
}
