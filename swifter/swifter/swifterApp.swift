//
//  swifterApp.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftUI

@main
struct swifterApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
