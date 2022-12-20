//
//  EpisodeRow.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct EpisodeRow: View {
    let episode: Episode
    
    var body: some View {
        HStack {
            RemoteImage(episode.imageUrl, placeholder: .tv)
                .scaledToFill()
                .frame(width: 80)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.headline)
                
                Text("S\(episode.seasonNumber), E\(episode.episodeNumber)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            EpisodeRow(episode: .sample)
            EpisodeRow(episode: .sample2)
            EpisodeRow(episode: .sample)
        }
        .listStyle(.plain)
    }
}
