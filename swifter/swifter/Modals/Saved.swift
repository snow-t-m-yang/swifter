//
//  Saved.swift
//  swifter
//
//  Created by S on 2024/8/28.
//

import Foundation
import SwiftData

@Model
final class Saved {
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
    
    static func fakeItems() -> [Saved] {
        return [
            Saved(id: UUID().uuidString, url: URL(string: "https://apple.com")!, group: "Technology", name: "Apple", date: .now),
            Saved(id: UUID().uuidString, url: URL(string: "https://swift.org")!, group: "Programming", name: "Swift", date: .now.addingTimeInterval(-3600)),
            Saved(id: UUID().uuidString, url: URL(string: "https://developer.apple.com")!, group: "Development", name: "Apple Developer", date: .now.addingTimeInterval(-7200))
        ]
    }
    
    static func fakeItem() -> Saved {
        return Saved.fakeItems().first!
    }
}
