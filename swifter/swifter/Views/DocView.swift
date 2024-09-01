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

    @State private var selectedDoc: Doc?
    @State private var isWebViewLoading = false
    @State private var currentURL: URL?

    @Query(sort: \Saved.date, order: .reverse) private var SavedItems: [Saved]

    func updateSaved(
        url: URL,
        group: String = "Default",
        name: String? = nil
    ) {
        if let existSaved = SavedItems.first(where: { $0.url == url }) {
            context.delete(existSaved)
            print("\(existSaved)")
            return
        }

        let newSaved = Saved(
            id: UUID().uuidString,
            url: url,
            group: group,
            name: name,
            date: .now
        )

        context.insert(newSaved)
        print(context)
    }

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
            .navigationDestination(isPresented: $modelData.isDocWebViewOpened) {
                if let doc = selectedDoc {
                    ZStack {
                        WebView(
                            url: URL(string: doc.urlString) ?? URL(string: "https://www.apple.com")!,
                            isWebViewLoading: $isWebViewLoading,
                            currentURL: $currentURL
                        )

                        if isWebViewLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.accentColor)
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
                            guard let url = currentURL else {
                                print("Invalid URL")
                                return
                            }
                            updateSaved(url: url)
                            print("Saving URL: \(url)")
                        } label: {
                            if isURLSaved(url: currentURL) {
                                Image(systemName: "bookmark.fill")
                            } else {
                                Image(systemName: "bookmark")
                            }
                        }
                    }
                }
            }
        }
    }

    private func isURLSaved(url: URL?) -> Bool {
        guard let url = url else { return false }
        return SavedItems.contains { $0.url == url }
    }
}

#Preview {
    DocView()
        .environment(ModelData())
}
