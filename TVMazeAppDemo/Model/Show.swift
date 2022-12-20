//
//  Show.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-18.
//

import Foundation

struct Show: Equatable, Hashable, Identifiable {
    struct Schedule: Equatable, Hashable, Decodable {
        let time: String
        let days: [String]
    }
    
    let id: Identifier<Self>
    let name: String
    let summary: String?
    let genres: [String]
    let imageUrl: URL?
    let schedule: Schedule
}


// MARK: Decodable

extension Show: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case summary
        case genres
        case imageUrl = "image"
        case schedule
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier<Self>.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.summary = try container.decode(String?.self, forKey: .summary)
        self.genres = try container.decode([String].self, forKey: .genres)
        
        let images = try container.decode([String: URL]?.self, forKey: .imageUrl)
        imageUrl = images?["medium"] ?? images?["original"]
        
        self.schedule = try container.decode(Schedule.self, forKey: .schedule)
    }
}
