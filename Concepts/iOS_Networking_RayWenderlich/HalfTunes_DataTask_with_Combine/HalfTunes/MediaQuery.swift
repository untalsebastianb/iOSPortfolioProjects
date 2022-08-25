//
//  MediaQuery.swift
//  HalfTunes
//
//  Created by Sebastian on 25/08/22.
//  Copyright © 2022 raywenderlich. All rights reserved.
//

import Combine
import Foundation

class MediaQuery: ObservableObject {
    @Published var itunesQuery = ""
    @Published var searchResults: [MusicItem] = []
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
        $itunesQuery
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap { query in
                let searchUrl = "https://itunes.apple.com/search?media=music&entity=song&term=\(query)"
                return URL(string: searchUrl)
            }
            .flatMap(fetchMusic)
            .receive(on: DispatchQueue.main)
            .assign(to: \.searchResults, on: self)
            .store(in: &subscriptions)
    }
    
    func fetchMusic(for url: URL ) -> AnyPublisher<[MusicItem], Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map {
                return $0.data
            }
            .decode(type: MediaResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
