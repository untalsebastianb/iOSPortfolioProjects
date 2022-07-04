//
//  SearchSongViewModel.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Combine
import Foundation

class SearchSongViewModel {
    
    private var musicSearchRepository: MusicSearchRepository
    private var subscriptions = Set<AnyCancellable>()
    
    init(musicSearchRepository: MusicSearchRepository) {
        self.musicSearchRepository = musicSearchRepository
        
        $songInput
            .sink(receiveValue: searchForSong(_:))
            .store(in: &subscriptions)
    }
    
    @Published public var songInput: String = ""
    @Published public private(set) var songResults: [Song] = []
    @Published public private(set) var isSearchByArtist: Bool = false
    
    private func searchForSong(_ song: String) {
        musicSearchRepository.search(song)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] songList in
                    self?.updateSongResult(songList.results)
                }
            ).store(in: &subscriptions)
    }
    
    private func updateSongResult(_ songResults: [Song]) {
        self.songResults = songResults
        print(songResults)
        searchByArtist()
    }
    
    private func searchByArtist() -> Void {
        let first5 = self.songResults.prefix(5)
        guard let artistID = first5.first?.artistID else { return }
        let haveSameArtist = first5.allSatisfy { $0.artistID == artistID }
        self.isSearchByArtist = haveSameArtist
    }
    
}
