//
//  PersonDetailView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject private var viewModel: ViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 120))
    ]
    
    init(person: Person) {
        _viewModel = StateObject(wrappedValue: ViewModel(person: person))
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                if viewModel.isLoading {
                    ProgressView()
                }
                else {
                    ForEach(viewModel.shows) { show in
                        NavigationLink(value: show) {
                            ShowGridTile(show: show)
                        }
                    }
                }
            }
        }
        .navigationDestination(for: Show.self) { show in
            ShowDetailView(show: show)
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Appearance Type", selection: $viewModel.appearanceType) {
                    Text("Cast")
                        .tag(Person.AppearanceType.cast)
                    Text("Crew")
                        .tag(Person.AppearanceType.crew)
                    Text("Guest Cast")
                        .tag(Person.AppearanceType.guestCast)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: .sample)
    }
}
