//
//  DocumentView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftData
import SwiftUI

struct DocView: View {
    @Environment(ModelData.self) var modelData: ModelData
    @Environment(\.modelContext) private var context

    @State private var webViewManager = WebViewManager()
    @State private var selectedDoc: Doc?

    @Query(sort: \Saved.date, order: .reverse) private var SavedItems: [Saved]

    var body: some View {
        @Bindable var modelData = modelData

        NavigationStack {
            List {
                ForEach(modelData.docs) { doc in
                    HStack {
                        Text(doc.name)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(4)
                        Spacer()
                        Button(action: {
                            modelData.isDocWebViewOpened.toggle()
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
                isPresented: $modelData.isDocWebViewOpened
            ) {
                if let doc = selectedDoc {
                    ZStack {
                        WebView(
                            url: URL(string: doc.urlString) ?? URL(
                                string: "https://www.apple.com")!,
                            isWebViewLoading: $webViewManager.isWebViewLoading,
                            currentURL: $webViewManager.currentURL
                        )

                        if webViewManager.isWebViewLoading {
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
            if modelData.isDocWebViewOpened {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            modelData.isDocWebViewOpened.toggle()
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
        .disabled(webViewManager.isWebViewLoading)
        .alert(
            "Notification",
            isPresented: $webViewManager.isAlertVisible
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
        .environment(ModelData())
}
