//
//  APIManagerProtocol.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Combine
import Foundation

protocol APIManagerProtocol {
    func perform(_ session: URLSession, request: URLRequest) -> URLSession.DataTaskPublisher
}

extension APIManagerProtocol {
    func perform(_ session: URLSession, request: URLRequest) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: request)
    }
}

class APIManager: APIManagerProtocol {}
