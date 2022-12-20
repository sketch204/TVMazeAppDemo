//
//  Episode.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

struct Episode: Equatable, Hashable, Identifiable {
    let id: Identifier<Self>
    let name: String
    let episodeNumber: Int
    let seasonNumber: Int
    let summary: String?
    let imageUrl: URL?
}


// MARK: Decodable

extension Episode: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case episodeNumber = "number"
        case seasonNumber = "season"
        case summary
        case imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier<Self>.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.episodeNumber = try container.decode(Int.self, forKey: .episodeNumber)
        self.seasonNumber = try container.decode(Int.self, forKey: .seasonNumber)
        self.summary = try container.decode(String.self, forKey: .summary)
        
        if let images = try container.decodeIfPresent([String: URL]?.self, forKey: .imageUrl) {
            imageUrl = images?["medium"] ?? images?["original"]
        } else {
            imageUrl = nil
        }
    }
}
