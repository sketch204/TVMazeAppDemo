//
//  ContentView.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        TabView {
            NavigationStack {
                ShowListView()
            }
//            .tabItem {
//                Label("Shows", systemImage: "play.tv")
//            }
//
//            NavigationStack {
//                PeopleSearchView()
//            }
//            .tabItem {
//                Label("People", systemImage: "magnifyingglass")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
