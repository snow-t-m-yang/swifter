//
//  TabView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftUI

struct MainTabView: View {
    @Environment(DocViewModel.self) var docViewModel

    var body: some View {
        TabView {
            DocView()
                .tabItem {
                    Label("Doc", systemImage: "book.pages")
                }

            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "safari")
                }
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environment(DocViewModel())
}
