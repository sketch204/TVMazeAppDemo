//
//  TVMazeService.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-18.
//

import Foundation

enum TVMazeService {
    private static let cloud = Cloud(baseUrl: URL(string: "https://api.tvmaze.com")!)
}


// MARK: Requests

extension CloudRequest {
    fileprivate static func allShows(page: Int) -> Self {
        Self(path: "/shows")
            .query(name: "page", value: "\(page)")
    }
    
    fileprivate static func searchShows(searchString: String) -> Self {
        Self(path: "/search/shows")
            .query(name: "q", value: searchString)
    }
    
    fileprivate static func showEpisodes(_ showId: Show.ID) -> Self {
        Self(path: "/shows/\(showId.rawValue)/episodes")
    }
    
    fileprivate static func personCastAppearance(id: Person.ID) -> Self {
        Self(path: "/people/\(id.rawValue)/castcredits")
            .query(name: "embed", value: "show")
    }
    
    fileprivate static func personCrewAppearance(id: Person.ID) -> Self {
        Self(path: "/people/\(id.rawValue)/crewcredits")
            .query(name: "embed", value: "show")
    }
    
    fileprivate static func personGuestCastAppearance(id: Person.ID) -> Self {
        Self(path: "/people/\(id.rawValue)/guestcastcredits")
            .query(name: "embed", value: "show")
    }
    
    fileprivate static func searchPeople(searchString: String) -> Self {
        Self(path: "/search/people")
            .query(name: "q", value: searchString)
    }
}


// MARK: Fetch All Shows

extension TVMazeService {
    static func fetchShows(
        page: Int
    ) async throws -> [Show] {
        try await cloud.fetch(
            .allShows(page: page),
            expecting: [Show].self
        ) { response in
            if response.statusCode == 404 {
                return []
            }
            return nil
        }
    }
}


// MARK: Find Shows

extension TVMazeService {
    private struct ShowSearchResult: Decodable {
        let score: Double
        let show: Show
    }
    
    static func searchShows(_ searchString: String) async throws -> [Show] {
        try await cloud.fetch(
            .searchShows(searchString: searchString),
            expecting: [ShowSearchResult].self
        )
        .map(\.show)
    }
}


// MARK: Fetch Show Episodes

extension TVMazeService {
    static func fetchEpisodes(for show: Show) async throws -> [[Episode]] {
        try await fetchEpisodes(for: show.id)
    }
    
    /// Fetches all episodes for the given show, broken down by season
    static func fetchEpisodes(for showId: Show.ID) async throws -> [[Episode]] {
        let allEpisodes = try await cloud.fetch(
            .showEpisodes(showId),
            expecting: [Episode].self
        )
        
        return Dictionary(grouping: allEpisodes, by: \.seasonNumber)
            .sorted(by: { $0.key < $1.key })
            .map(\.value)
    }
}


// MARK: Find People

extension TVMazeService {
    private struct PersonSearchResult: Decodable {
        let score: Double
        let person: Person
    }
    
    static func searchPeople(_ searchString: String) async throws -> [Person] {
        try await cloud.fetch(
            .searchPeople(searchString: searchString),
            expecting: [PersonSearchResult].self
        )
        .map(\.person)
    }
}


// MARK: Fetch Person Show Appearances

extension TVMazeService {
    private struct AppearanceResult: Decodable {
        struct Embedded: Decodable {
            let show: Show
        }
        let _embedded: Embedded
    }
    
    static func fetchPersonAppearances(for person: Person) async throws -> (cast: [Show], crew: [Show], guestCast: [Show]) {
        try await fetchPersonAppearances(for: person.id)
    }
    
    static func fetchPersonAppearances(for id: Person.ID) async throws -> (cast: [Show], crew: [Show], guestCast: [Show]) {
        async let cast = try await cloud.fetch(.personCastAppearance(id: id), expecting: [AppearanceResult].self)
            .map(\._embedded.show)
        async let crew = try await cloud.fetch(.personCrewAppearance(id: id), expecting: [AppearanceResult].self)
            .map(\._embedded.show)
        async let guestCast = try await cloud.fetch(.personGuestCastAppearance(id: id), expecting: [AppearanceResult].self)
            .map(\._embedded.show)
        
        return try await (cast, crew, guestCast)
    }
}
