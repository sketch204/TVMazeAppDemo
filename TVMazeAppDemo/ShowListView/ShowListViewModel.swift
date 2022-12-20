//
//  ShowListViewModel.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-18.
//

import Foundation
import Combine

extension ShowListView {
    @MainActor
    final class ViewModel: ObservableObject {
        enum PresentationMode {
            case allShows
            case search
        }
        
        @Published var shows = [Show]()
        @Published var presentationMode = PresentationMode.allShows
        
        @Published var searchString = ""
        
        @Published private(set) var canLoadNextPage: Bool = true
        
        @Published private var allShows = [Show]()
        @Published private var searchResults = [Show]()
        @Published private var loadNextPageTask: Task<Void, Never>?
        @Published private var searchTask: Task<Void, Never>?
        
        private var isPendingRefresh = false
        private var currentPage: Int = -1
        
        private var subscriptions = Set<AnyCancellable>()
        
        var isLoadingNextPage: Bool { loadNextPageTask != nil }
        var isSearching: Bool { searchTask != nil }
        
        init() {
            $searchString
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .sink { [weak self] _ in
                    self?.performSearch()
                }
                .store(in: &subscriptions)
            
            loadNextPage()
        }
        
        func refresh() {
            Task {
                refresh()
            }
        }
        
        func refresh() async {
            resetPagination()
            await loadNextPage()
        }
        
        private func resetPagination() {
            isPendingRefresh = true
            currentPage = -1
        }
        
        func loadNextPage() {
            Task {
                await loadNextPage()
            }
        }
        
        func loadNextPage() async {
            if let loadNextPageTask {
                return await loadNextPageTask.value
            }
            
            loadNextPageTask = Task {
                await loadNextPageUnsynchronized()
                loadNextPageTask = nil
            }
            return await loadNextPageTask!.value
        }
        
        private func loadNextPageUnsynchronized() async {
            guard canLoadNextPage else { return }
            
            currentPage += 1
            
            do {
                let newShows = try await TVMazeService.fetchShows(page: currentPage)
                
                if isPendingRefresh {
                    isPendingRefresh = false
                    allShows = []
                }
                
                allShows.append(contentsOf: newShows)
                
                if newShows.isEmpty {
                    canLoadNextPage = false
                }
                
                refreshPresentedShows()
            } catch {
                print("ERROR: Failed to load shows due to error! \(error)")
            }
        }
        
        private func refreshPresentedShows() {
            switch presentationMode {
            case .allShows:
                shows = allShows
            case .search:
                shows = searchResults
            }
        }
    }
}


// MARK: Search

extension ShowListView.ViewModel {
    func performSearch() {
        guard !searchString.isEmpty else {
            presentationMode = .allShows
            return
        }
        
        searchTask?.cancel()
        searchTask = Task {
            do {
                searchResults = try await TVMazeService.searchShows(searchString)
                presentationMode = .search
                refreshPresentedShows()
            }
            catch is CancellationError {}
            catch {
                print("ERROR: Failed to search shows due to error! \(error)")
            }
            
            searchTask = nil
        }
    }
}
