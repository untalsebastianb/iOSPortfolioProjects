//
//  MusicNetworkManager.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Combine
import Foundation

fileprivate protocol NetworkManagerProtocol {
    var apiManager: APIManagerProtocol { get }
    
    func search(_ request: URLRequest) -> AnyPublisher<SongList, Error>
}

class MusicNetworkManager: NetworkManagerProtocol {
    
    fileprivate var apiManager: APIManagerProtocol
    private let session: URLSession
    
    init() {
        self.session = .init(configuration: .default)
        self.apiManager = APIManager()
    }
    
    init(session: URLSession, apiManager: APIManagerProtocol) {
        self.session = session
        self.apiManager = apiManager
    }
    
    private var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    func search(_ request: URLRequest) -> AnyPublisher<SongList, Error> {
        return apiManager.perform(session, request: request)
            .tryMap { output -> Data in
                return output.data
            }
            .decode(type: SongList.self, decoder: decoder)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
