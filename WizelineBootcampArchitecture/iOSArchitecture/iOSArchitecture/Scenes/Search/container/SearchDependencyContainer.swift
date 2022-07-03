//
//  SearchDependencyContainer.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 28/06/22.
//

import Foundation

final class SearchDependencyContainer {
    
    private func makeMusicSearchRequest() -> MusicSearchRequest {
        return MusicSearchRequest()
    }
    
    private func makeMusicNetworkManager() -> MusicNetworkManager {
        return MusicNetworkManager()
    }
    
    private func makeMusicSearchRepository() -> MusicSearchRepository {
        let musicSearchRequest = makeMusicSearchRequest()
        let musicNetworkManager = makeMusicNetworkManager()
        return MusicSearchRepository(musicSearchRequest: musicSearchRequest, musicNetworkManager: musicNetworkManager)
    }
    
    private func makeSearchSongViewModel() -> SearchSongViewModel {
        let musicSearchRepository = makeMusicSearchRepository()
        return SearchSongViewModel(musicSearchRepository: musicSearchRepository)
    }
    
    func makeSearchViewController() -> SearchViewController {
        let searchSongViewModel = makeSearchSongViewModel()
        return SearchViewController(viewModel: searchSongViewModel)
    }
}
