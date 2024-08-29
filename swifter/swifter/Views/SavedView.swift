//
//  SavedView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftData
import SwiftUI

struct SavedView: View {
    @Environment(ModelData.self) var modelData: ModelData
    @Environment(\.modelContext) private var context

    @Query(sort: \Saved.date, order: .reverse) private var SavedItems: [Saved]

    var body: some View {
        List {
            if !SavedItems.isEmpty {
                ForEach(SavedItems, id: \.id) { savedItem in
                    HStack {
                        Text(savedItem.date.formatted())
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(4)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.accentColor)
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .overlay {
            if SavedItems.isEmpty {
                ContentUnavailableView(label: {
                    Label("You have no saved yet", systemImage: "figure.snowboarding")
                }, description: {
                    Text("Add url")
                }, actions: {
                    Button("hi") {}
                })
                .offset(y: -60)
            }
        }
    }
}

#Preview {
    SavedView()
        .environment(ModelData())
}
