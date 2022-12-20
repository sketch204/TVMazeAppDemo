//
//  ShowDetailViewModel.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

extension ShowDetailView {
    @MainActor
    final class ViewModel: ObservableObject {
        let show: Show
        
        @Published var episodes = [[Episode]]()
        
        @Published private var loadEpisodesTask: Task<Void, Never>?
        var isLoadingEpisodes: Bool { loadEpisodesTask != nil }
        
        init(show: Show) {
            self.show = show
            
            refreshEpisodes()
        }
        
        
        func refreshEpisodes() {
            Task {
                await refreshEpisodes()
            }
        }
        
        func refreshEpisodes() async {
            if let loadEpisodesTask {
                return await loadEpisodesTask.value
            }
            
            loadEpisodesTask = Task {
                await refreshEpisodesUnsynchronized()
                loadEpisodesTask = nil
            }
            return await loadEpisodesTask!.value
        }
        
        private func refreshEpisodesUnsynchronized() async {
            do {
                let episodes = try await TVMazeService.fetchEpisodes(for: show)
                self.episodes = episodes
            }
            catch {
                print("Failed to fetch episodes for show with ID \(show.id) due to error! \(error)")
            }
        }
    }
}
