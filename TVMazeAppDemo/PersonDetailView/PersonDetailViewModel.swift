//
//  PersonDetailViewModel.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

extension PersonDetailView {
    @MainActor
    final class ViewModel: ObservableObject {
        let person: Person
        
        @Published private(set) var cast = [Show]()
        @Published private(set) var crew = [Show]()
        @Published private(set) var guestCast = [Show]()
        @Published var appearanceType: Person.AppearanceType = .cast
        
        var shows: [Show] {
            switch appearanceType {
            case .cast: return cast
            case .crew: return crew
            case .guestCast: return guestCast
            }
        }
        
        var isLoading: Bool { refreshTask != nil }
        
        @Published private var refreshTask: Task<Void, Never>?
        
        init(person: Person) {
            self.person = person
            
            refresh()
        }
  
        func refresh() {
            Task {
                await refresh()
            }
        }

        func refresh() async {
            if let refreshTask {
                return await refreshTask.value
            }

            refreshTask = Task {
                await refreshUnsynchronized()
                refreshTask = nil
            }
            return await refreshTask!.value
        }

        private func refreshUnsynchronized() async {
            do {
                let appearances = try await TVMazeService.fetchPersonAppearances(for: person)

                cast = appearances.cast
                crew = appearances.crew
                guestCast = appearances.guestCast
            } catch {
                print("ERROR: Failed to load shows due to error! \(error)")
            }
        }
    }
}
