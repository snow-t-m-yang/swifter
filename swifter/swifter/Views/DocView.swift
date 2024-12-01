//
//  DocumentView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftData
import SwiftUI

struct DocView: View {
    // For hardcoded category
    @Environment(DocViewModel.self) var docViewModel: DocViewModel
    @Environment(\.modelContext) private var context

    @State private var webViewManager = WebViewManager()
    @State private var selectedDoc: Doc?

    @Query(sort: \Saved.date, order: .reverse) private var SavedItems: [Saved]

    var body: some View {
        NavigationStack {
            List {
                ForEach(docViewModel.docs) { doc in
                    HStack {
                        Text(doc.name)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(4)
                        Spacer()
                        Button(action: {
                            webViewManager.isShown.toggle()
                            selectedDoc = doc
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                                .font(.title2)
                        }
                    }
                }
            }
            .navigationTitle("Doc")
            .listStyle(.insetGrouped)
            .navigationDestination(
                isPresented: $webViewManager.isShown
            ) {
                if let doc = selectedDoc {
                    ZStack {
                        WebView(
                            url: URL(string: doc.urlString) ?? URL(
                                string: "https://www.apple.com")!,
                            isWebViewLoading: $webViewManager.isLoading,
                            currentURL: $webViewManager.currentURL
                        )

                        if webViewManager.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.accent)
                                .scaleEffect(1.5)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
        .toolbar {
            if webViewManager.isShown {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            webViewManager.isShown.toggle()
                        } label: {
                            Image(systemName: "arrow.uturn.backward")
                        }

                        Button {
                            guard let url = webViewManager.currentURL else {
                                print("Invalid URL")
                                return
                            }
                            webViewManager.updateSavedItems(
                                url: url, savedItems: SavedItems,
                                context: context)
                        } label: {
                            if webViewManager.isURLSaved(
                                url: webViewManager.currentURL,
                                savedItems: SavedItems
                            ) {
                                Image(systemName: "bookmark.fill")
                            } else {
                                Image(systemName: "bookmark")
                            }
                        }
                    }
                }
            }
        }
        .disabled(webViewManager.isLoading)
        .alert(
            "Notification",
            isPresented: $webViewManager.isAlertShown
        ) {
            Button("OK") {
                // Handle the acknowledgement.
            }
        } message: {
            Text(webViewManager.alertMessage)
        }
    }
}

#Preview {
    DocView()
        .environment(DocViewModel())
}
