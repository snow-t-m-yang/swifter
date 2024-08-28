//
//  DocumentView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftUI

struct DocView: View {
    @Environment(ModelData.self) var modelData: ModelData
    @State private var selectedDoc: Doc?
    @State private var isWebViewLoading = false

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
                            isWebViewLoading: $isWebViewLoading
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
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    DocView()
        .environment(ModelData())
}
