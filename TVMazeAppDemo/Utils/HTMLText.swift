//
//  HTMLText.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import SwiftUI

struct HTMLText: View {
    let html: String
    
    @State private var attributedString: AttributedString?
    
    init(html: String) {
        self.html = html
    }
    
    var body: some View {
        Group {
            if let attributedString {
                Text(attributedString)
            }
            else {
                Text(html)
            }
        }
        .task {
            // Weird glitch with this constructor. It cannot be called at instantiation time
            attributedString = AttributedString(html: html)
        }
    }
}

struct HTMLText_Previews: PreviewProvider {
    static var previews: some View {
        HTMLText(html: "")
    }
}
