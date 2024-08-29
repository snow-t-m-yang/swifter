//
//  Saved.swift
//  swifter
//
//  Created by S on 2024/8/28.
//

import Foundation
import SwiftData

@Model
class Saved {
    @Attribute(.unique) var id: String
    var url: URL
    var group: String
    var name: String?
    var date: Date

    init(
        id: String = UUID().uuidString,
        url: URL,
        group: String,
        name: String? = nil,
        date: Date
    ) {
        self.id = id
        self.url = url
        self.group = group
        self.name = name
        self.date = date
    }
}
