//
//  CloudRequest.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

struct CloudRequest {
    private let path: String
    private let query: [URLQueryItem]
    
    init(path: String, query: [URLQueryItem] = []) {
        self.path = path
        self.query = query
    }
    
    func url(resolvingAgainst base: URL) throws -> URL {
        guard var comps = URLComponents(url: base, resolvingAgainstBaseURL: false) else {
            throw Cloud.Error.invalidURL
        }
        comps.path = path
        comps.queryItems = query
        return comps.url!
    }
}


extension CloudRequest {
    func query(name: String, value: String?) -> Self {
        Self(path: path, query: query + [URLQueryItem(name: name, value: value)])
    }
}
