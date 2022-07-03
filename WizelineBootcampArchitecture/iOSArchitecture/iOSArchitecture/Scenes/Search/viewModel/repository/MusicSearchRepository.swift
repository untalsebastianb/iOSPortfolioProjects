//
//  MusicSearchRepository.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Combine
import Foundation

class MusicSearchRepository: SearchRepository {
    
    private var musicSearchRequest: MusicSearchRequest
    private var musicNetworkManager: MusicNetworkManager
    
    init(musicSearchRequest: MusicSearchRequest, musicNetworkManager: MusicNetworkManager) {
        self.musicSearchRequest = musicSearchRequest
        self.musicNetworkManager = musicNetworkManager
    }
    
    func search(_ song: String) -> AnyPublisher<SongList, Error> {
        musicSearchRequest.song = song
        let request = try! musicSearchRequest.createUrlRequest()
        return musicNetworkManager.search(request)
    }
}
