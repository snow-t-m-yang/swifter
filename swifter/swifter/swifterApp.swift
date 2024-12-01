//
//  swifterApp.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftData
import SwiftUI

@main
struct swifterApp: App {
    @State private var modelData = DocViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
        .modelContainer(for: Saved.self)
    }
}
