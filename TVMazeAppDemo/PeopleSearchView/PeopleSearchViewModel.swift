//
//  PeopleSearchView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation
import Combine

extension PeopleSearchView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var searchString = ""
        @Published private(set) var results = [Person]()
        
        var isSearching: Bool { searchTask != nil }
        
        @Published private var searchTask: Task<Void, Never>?
        
        private var subscriptions = Set<AnyCancellable>()
        
        init() {
            $searchString
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .sink { [weak self] _ in
                    self?.performSearch()
                }
                .store(in: &subscriptions)
        }
        
        func performSearch() {
            guard !searchString.isEmpty else {
                results = []
                return
            }
            
            searchTask?.cancel()
            searchTask = Task {
                do {
                    results = try await TVMazeService.searchPeople(searchString)
                }
                catch is CancellationError {}
                catch {
                    print("ERROR: Failed to search shows due to error! \(error)")
                }
                
                searchTask = nil
            }
        }
    }
}
