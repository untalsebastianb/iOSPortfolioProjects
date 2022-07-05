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
    private var albumSearchRequest: AlbumSearchRequest
    private var musicNetworkManager: MusicNetworkManager
    
    init(musicSearchRequest: MusicSearchRequest, musicNetworkManager: MusicNetworkManager, albumSearchRequest: AlbumSearchRequest) {
        self.musicSearchRequest = musicSearchRequest
        self.musicNetworkManager = musicNetworkManager
        self.albumSearchRequest = albumSearchRequest
    }
    
    func search(_ song: String) -> AnyPublisher<SongList, Error> {
        musicSearchRequest.song = song
        let request = try! musicSearchRequest.createUrlRequest()
        return musicNetworkManager.search(request)
    }
    func searchAlbum(_ id: Int) -> AnyPublisher<AlbumList, Error> {
        albumSearchRequest.id = id
        let request = try! albumSearchRequest.createUrlRequest()
        return musicNetworkManager.searchAlbum(request)
    }
}
