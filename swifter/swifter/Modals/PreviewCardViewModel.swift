//
//  PreviewCardViewModel.swift
//  swifter
//
//  Created by snow on 2024/11/30.
//

// Learnt from: https://medium.com/@alaputska/creating-custom-link-preview-instead-of-lplinkview-with-swiftui-909512a4cb27

import LinkPresentation
import SwiftUI
import UniformTypeIdentifiers

@Observable final class PreviewCardViewModel {
    var image: UIImage?
    var title: String?
    var url: String?

    let previewURL: URL?

    var isLoading: Bool = false

    init(_ url: String) {
        self.previewURL = URL(string: url)

        fetchMetadata()
    }

    private func convertToImage(_ imageProvider: NSItemProvider?) async throws
        -> UIImage?
    {
        var image: UIImage?

        if let imageProvider {
            let type = String(describing: UTType.image)

            if imageProvider.hasItemConformingToTypeIdentifier(type) {
                let item = try await imageProvider.loadItem(
                    forTypeIdentifier: type)

                if item is UIImage {
                    image = item as? UIImage
                }

                if item is URL {
                    guard let url = item as? URL,
                        let data = try? Data(contentsOf: url)
                    else { return nil }

                    image = UIImage(data: data)
                }

                if item is Data {
                    guard let data = item as? Data else { return nil }

                    image = UIImage(data: data)
                }
            }
        }

        return image
    }

    private func fetchMetadata() {
        guard let previewURL else { return }
        let provider = LPMetadataProvider()

        isLoading = true

        Task {
            do {
                let metadata = try await provider.startFetchingMetadata(
                    for: previewURL)
                image = try await convertToImage(metadata.imageProvider)
                title = metadata.title

                url = metadata.url?.lastPathComponent

            } catch {
                print("Failed to fetch metadata \(error)")
            }
            isLoading = false
        }

    }
}
