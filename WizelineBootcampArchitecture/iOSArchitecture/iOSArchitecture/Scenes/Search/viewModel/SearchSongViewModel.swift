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
    }
}
