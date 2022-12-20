//
//  Show+Samples.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

extension Show {
    static var samples: [Self] {
        Array(repeating: [sample, sample2, sample3, sample4], count: 5)
            .flatMap { $0 }
            .shuffled()
    }
    
    static var sample: Self {
        Self(
            id: 0,
            name: "Breaking Bad",
            summary: "Some summary goes here",
            genres: ["Suspense", "Thriller", "Crime"],
            imageUrl: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Breaking_Bad_logo.svg/2880px-Breaking_Bad_logo.svg.png"),
            schedule: Schedule(time: "20:00", days: ["Thursdays"])
        )
    }
    
    static var sample2: Self {
        Self(
            id: 0,
            name: "The Expanse",
            summary: "Awesome sci-fi show",
            genres: ["Suspense", "Thriller", "Sci-Fi"],
            imageUrl: nil,
            schedule: Schedule(time: "20:00", days: ["Thursdays"])
        )
    }
    
    static var sample3: Self {
        Self(
            id: 0,
            name: "Game of Thrones",
            summary: "Throne of Games",
            genres: ["Fantasy", "Medieval", "Dragons"],
            imageUrl: nil,
            schedule: Schedule(time: "20:00", days: ["Thursdays"])
        )
    }
    
    static var sample4: Self {
        Self(
            id: 0,
            name: "Big Bang Theory",
            summary: "The theory of the big bang",
            genres: ["Comedy", "Sitcom"],
            imageUrl: nil,
            schedule: Schedule(time: "20:00", days: ["Thursdays"])
        )
    }
}
