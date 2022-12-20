//
//  Episode+Samples.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

extension Episode {
    static var sample: Self {
        Self(
            id: 1,
            name: "Pilot",
            episodeNumber: 1,
            seasonNumber: 1,
            summary: "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
            imageUrl: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg")
        )
    }
    
    static var sample2: Self {
        Self(
            id: 1,
            name: "Not Pilot",
            episodeNumber: 2,
            seasonNumber: 1,
            summary: "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
            imageUrl: nil
        )
    }
}
