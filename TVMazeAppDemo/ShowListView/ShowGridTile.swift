//
//  ShowGridTile.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-18.
//

import SwiftUI

struct ShowGridTile: View {
    let show: Show
    
    var body: some View {
        RemoteImage(show.imageUrl, placeholder: .tv)
            .scaledToFill()
            .frame(width: 120, height: 200)
            .clipShape(Rectangle())
            .overlay(alignment: .bottomLeading) {
                Text(show.name)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.7))
            }
    }
}

struct ShowGridTile_Previews: PreviewProvider {
    static var previews: some View {
        ShowGridTile(show: .sample)
            .background(Color.black)
    }
}
