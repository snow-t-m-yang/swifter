//
//  WebViewManager.swift
//  swifter
//
//  Created by snow on 2024/12/1.
//

import Foundation
import SwiftData
import SwiftUI

@Observable final class WebViewManager {
    var isWebViewLoading: Bool = false
    var isAlertVisible: Bool = false

    var alertMessage: String = ""
    var currentURL: URL?

    func isURLSaved(url: URL?, savedItems: [Saved]) -> Bool {
        guard let url else { return false }
        return savedItems.contains { $0.url == url }
    }

    func updateSavedItems(
        url: URL,
        group: String = "Default",
        name: String? = nil,
        savedItems: [Saved],
        context: ModelContext
    ) {
        if let existingItem = savedItems.first(where: { $0.url == url }) {
            context.delete(existingItem)
            print("Removed item: \(existingItem)")
            alertMessage = "Removed from Saved!"
        } else {
            let newSavedItem = Saved(
                id: UUID().uuidString,
                url: url,
                group: group,
                name: name,
                date: .now
            )
            context.insert(newSavedItem)
            print("Added item: \(newSavedItem)")
            alertMessage = "Added to Saved!"
        }
        isAlertVisible = true
    }

}
