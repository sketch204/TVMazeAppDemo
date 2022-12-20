//
//  ShowDetailView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct ShowDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    private var show: Show { viewModel.show }
    
    init(show: Show) {
        _viewModel = StateObject(wrappedValue: ViewModel(show: show))
    }
    
    var body: some View {
        List {
            HStack(alignment: .top) {
                RemoteImage(show.imageUrl, placeholder: .tv)
                    .scaledToFill()
                    .frame(width: 120, height: 200)
                    .clipShape(Rectangle())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(show.name)
                        .font(.title)
                    
                    Group {
                        Text("Genre:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(show.genres.formatted())
                    }
                    
                    Group {
                        Text("Schedule:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(show.schedule.days.formatted()) + Text(" at ") + Text(show.schedule.time)
                    }
                }
            }
            
            if let summary = show.summary {
                HTMLText(html: summary)
            }
            
            if viewModel.isLoadingEpisodes {
                ProgressView()
            }
            else {
                ForEach(viewModel.episodes.indices, id: \.self) { season in
                    Section("Season \(season + 1)") {
                        let episodes = viewModel.episodes[season]
                        ForEach(episodes) { episode in
                            NavigationLink(value: episode) {
                                EpisodeRow(episode: episode)
                            }
                        }
                    }
                }
            }
        }
        .refreshable {
            await viewModel.refreshEpisodes()
        }
        .navigationDestination(for: Episode.self) { episode in
            EpisodeDetailView(episode: episode)
                .navigationTitle(show.name)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailView(show: .sample)
    }
}
