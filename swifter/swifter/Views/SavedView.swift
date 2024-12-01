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
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 5
            ) {
                ForEach(SavedItems, id: \.id) { savedItem in
                    PreviewCardView(
                        previewCardModel: PreviewCardViewModel(
                            savedItem.url.absoluteString))
                }
            }
            .padding()
        }
        .navigationTitle("Saved")
        .overlay {
            if SavedItems.isEmpty {
                VStack {
                    Image(systemName: "tray")
                        .font(.title)
                        .foregroundColor(.gray)
                    Text("You have no saved yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    SavedView()
        .environment(ModelData())
}
