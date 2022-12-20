//
//  RemoteImage.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI
import SDWebImageSwiftUI

struct RemoteImage: View {
    enum Placeholder: String {
        case tv = "play.tv"
        case person = "person.circle"
    }
    
    let imageUrl: URL?
    let placeholder: Placeholder
    
    init(_ imageUrl: URL?, placeholder: Placeholder) {
        self.imageUrl = imageUrl
        self.placeholder = placeholder
    }
    
    var body: some View {
        WebImage(url: imageUrl)
            .resizable()
            .placeholder {
                Image(systemName: placeholder.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .foregroundColor(.secondary)
            }
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(nil, placeholder: .tv)
    }
}
