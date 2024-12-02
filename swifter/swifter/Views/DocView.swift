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
                            webViewManager.currentURL = URL(
                                string: doc.urlString)
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
                WebViewContainer(
                    manager: webViewManager, SavedItems: SavedItems)
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
