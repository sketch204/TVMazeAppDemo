//
//  Cloud.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

struct Cloud {
    struct Error: Swift.Error {
        let code: Int
        let message: String
        
        static let unknownError = Self(code: 0, message: "Unknown error")
        static let invalidResponse = Self(code: 1, message: "Invalid response received")
        static let invalidURL = Self(code: 2, message: "Invalid URL")
    }
    
    private var urlSession: URLSession { .shared }
    
    let baseUrl: URL
    
    
    func fetch<Result>(
        _ request: CloudRequest,
        expecting: Result.Type,
        errorHandler: ((_ response: HTTPURLResponse) throws -> Result?)? = nil
    ) async throws -> Result
        where Result: Decodable
    {
        let (data, response) = try await urlSession.data(from: request.url(resolvingAgainst: baseUrl))
        
        guard let response = response as? HTTPURLResponse else {
            throw Error.invalidResponse
        }
        
        guard (200..<300).contains(response.statusCode) else {
            if let errorHandler, let errorOutput = try errorHandler(response) {
                return errorOutput
            }
            throw Error.invalidResponse
        }
        
        return try JSONDecoder().decode(Result.self, from: data)
    }
}
