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
                            modelData.isDocWebViewOpened = true
                            modelData.isDocWebViewOpened = true
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
                        WebView(url: URL(string: doc.urlString) ?? URL(string: "https://www.apple.com")!)
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
        .toolbar {
            if modelData.isDocWebViewOpened {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            modelData.isDocWebViewOpened = false
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
