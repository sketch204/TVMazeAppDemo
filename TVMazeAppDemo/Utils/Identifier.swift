//
//  Identifier.swift
//  TVMazeAppDemo
//
//  Created by Inal Gotov on 2022-12-19.
//

import Foundation

struct Identifier<Model>: RawRepresentable, Equatable, Hashable, Codable {
    let rawValue: Int
}

extension Identifier: ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self.init(rawValue: value)
    }
}
