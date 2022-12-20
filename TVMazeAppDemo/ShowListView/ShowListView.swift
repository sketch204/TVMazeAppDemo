//
//  ShowListView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-18.
//

import SwiftUI

struct ShowListView: View {
    @StateObject private var viewModel = ViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 120))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                if viewModel.isSearching {
                    ProgressView()
                }
                else {
                    ForEach(viewModel.shows) { show in
                        NavigationLink(value: show) {
                            ShowGridTile(show: show)
                        }
                    }
                    
                    if viewModel.presentationMode == .allShows && viewModel.canLoadNextPage {
                        ProgressView()
                            .onAppear {
                                viewModel.loadNextPage()
                            }
                    }
                }
            }
        }
        .navigationDestination(for: Show.self) { show in
            ShowDetailView(show: show)
        }
        .refreshable {
            await viewModel.refresh()
        }
        .searchable(text: $viewModel.searchString)
        .navigationTitle("Shows")
    }
}

struct ShowListView_Previews: PreviewProvider {
    static var previews: some View {
        ShowListView()
    }
}
