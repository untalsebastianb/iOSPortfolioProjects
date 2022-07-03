//
//  RequestProtocol.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var parameters: [String : String] { get }
    
    func createUrlRequest() throws -> URLRequest
}

extension RequestProtocol {
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        return "itunes.apple.com"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    func createUrlRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        
        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidUrl
        }
        
        return URLRequest(url: url)
    }
}
