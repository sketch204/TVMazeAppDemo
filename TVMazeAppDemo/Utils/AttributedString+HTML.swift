//
//  AttributedString+HTML.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation
import UIKit

extension AttributedString {
    init?(html: String) {
        let nsAttributedString = try? NSMutableAttributedString(
            data: Data(html.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        
        guard let nsAttributedString else { return nil }
        
        nsAttributedString.setAttributes(
            [
                .font: UIFont.preferredFont(forTextStyle: .body),
                .foregroundColor: UIColor.label
            ],
            range: NSRange(location: 0, length: nsAttributedString.length)
        )
        
        self.init(nsAttributedString)
    }
}
