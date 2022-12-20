//
//  Person.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

struct Person: Equatable, Hashable, Identifiable {
    let id: Identifier<Person>
    let name: String
    let imageUrl: URL?
}


// MARK: AppearanceType

extension Person {
    enum AppearanceType: Equatable, Hashable {
        case cast
        case crew
        case guestCast
    }
}

extension Person.AppearanceType: Identifiable {
    var id: Self { self }
}


// MARK: Decodable

extension Person: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier<Self>.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        if let images = try container.decodeIfPresent([String: URL]?.self, forKey: .imageUrl) {
            imageUrl = images?["medium"] ?? images?["original"]
        } else {
            imageUrl = nil
        }
    }
}
