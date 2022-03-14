//
//  Endpoints.swift
//  MiniTwitterApp
//
//  Created by Sebastian on 14/03/22.
//

import Foundation

struct Endpoints {
    static let domain = "https://platzi-tweets-backend.herokuapp.com/api/v1"
    static let login = Endpoints.domain + "/auth"
    static let register = Endpoints.domain + "/register"
    static let gettwiits = Endpoints.domain + "/posts"
    static let postTwiits = Endpoints.domain + "/posts"
    static let delete = Endpoints.domain + "/posts"
}
