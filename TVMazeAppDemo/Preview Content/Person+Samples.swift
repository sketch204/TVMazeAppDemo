//
//  Person+Samples.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

extension Person {
    static var sample: Self {
        Self(
            id: 1,
            name: "Emilia Clarke",
            imageUrl: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/54/136753.jpg")
        )
    }
    
    static var sample2: Self {
        Self(
            id: 1,
            name: "Henry Cavill",
            imageUrl: nil
        )
    }
}
