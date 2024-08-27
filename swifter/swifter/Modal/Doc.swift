//
//  Doc.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import Foundation

struct Doc: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var category: String
    var urlString: String
}
