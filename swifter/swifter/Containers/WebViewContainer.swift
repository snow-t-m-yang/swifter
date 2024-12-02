//
//  WebViewContainer.swift
//  swifter
//
//  Created by snow on 2024/12/2.
//

import SwiftUI

struct WebViewContainer: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var manager: WebViewManager

    let SavedItems: [Saved]

    var body: some View {
        ZStack {
            if let url = manager.currentURL {
                WebView(
                    url: url,
                    isWebViewLoading: $manager.isLoading,
                    currentURL: $manager.currentURL
                )
            } else {
                Text("No URL provided")
            }

            if manager.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.accent)
                    .scaleEffect(1.5)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        manager.isShown.toggle()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }

                    Button {
                        guard let url = manager.currentURL else { return }
                        manager.updateSavedItems(
                            url: url, savedItems: SavedItems,
                            context: modelContext)
                    } label: {
                        Image(
                            systemName: manager.isURLSaved(
                                url: manager.currentURL, savedItems: SavedItems)
                                ? "bookmark.fill" : "bookmark")
                    }
                }
            }
        }
    }
}

#Preview {
    WebViewContainer(
        manager: WebViewManager(),
        SavedItems: Saved.fakeItems()
    )
}
