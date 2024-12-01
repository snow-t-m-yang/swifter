//
//  CardView.swift
//  swifter
//
//  Created by snow on 2024/11/30.
//

import SwiftUI

struct PreviewCardView: View {
    let previewCardModel: PreviewCardViewModel

    var body: some View {
        GroupBox {
            VStack(spacing: 20) {
                let hasImage = previewCardModel.image != nil

                Image(
                    uiImage: previewCardModel.image ?? UIImage(
                        systemName: "book")!
                )
                .resizable()
                .aspectRatio(
                    contentMode: .fit
                )
                .frame(
                    maxWidth: hasImage ? .infinity : 107,
                    maxHeight: 107
                )
                .clipped(antialiased: true)
                .cornerRadius(7)
                .colorInvert()

                if let url = previewCardModel.url {
                    Text(url)
                        .font(.headline)
                        .foregroundColor(.accent)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                }

            }

        } label: {
            if let title = previewCardModel.title {
                Text(title)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }

        }

    }
}

#Preview {
    PreviewCardView(
        previewCardModel: PreviewCardViewModel(
            Saved.fakeItem().url.absoluteString))
}
