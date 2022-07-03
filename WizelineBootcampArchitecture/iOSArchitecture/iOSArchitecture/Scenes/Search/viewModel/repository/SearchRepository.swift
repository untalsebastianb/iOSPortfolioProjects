//
//  SearchRepository.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Combine
import Foundation

protocol SearchRepository {
    func search(_ song: String) -> AnyPublisher<SongList, Error>
}
