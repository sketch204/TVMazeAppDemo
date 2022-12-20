//
//  EpisodeDetailView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct EpisodeDetailView: View {
    let episode: Episode
    
    var body: some View {
        List {
            if let imageUrl = episode.imageUrl {
                RemoteImage(imageUrl, placeholder: .tv)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(Rectangle())
                    .listRowInsets(EdgeInsets())
            }
            
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.title)
                
                Text("Season \(episode.seasonNumber), Episode \(episode.episodeNumber)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            
            if let summary = episode.summary {
                HTMLText(html: summary)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EpisodeDetailView(episode: .sample)
        }
        
        NavigationStack {
            EpisodeDetailView(episode: .sample2)
        }
    }
}
