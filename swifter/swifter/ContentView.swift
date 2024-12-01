//
//  ContentView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    ContentView()
        .environment(DocViewModel())
        .modelContainer(
            for: Saved.self,
            isAutosaveEnabled: true
        )
}
