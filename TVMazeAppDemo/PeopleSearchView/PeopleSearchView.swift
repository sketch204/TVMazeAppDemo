//
//  PeopleSearchView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct PeopleSearchView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.results) { person in
            NavigationLink(value: person) {
                PersonRow(person: person)
            }
        }
        .overlay {
            if viewModel.searchString.isEmpty {
                Text("Search Cast, Crew or Guest Appearances")
                    .font(.title)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationDestination(for: Person.self) { person in
            PersonDetailView(person: person)
        }
        .searchable(text: $viewModel.searchString, prompt: Text("Search People"))
    }
}

struct PeopleSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleSearchView()
    }
}
