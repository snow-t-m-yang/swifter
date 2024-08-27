//
//  SafariView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context _: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        var Safari = SFSafariViewController(url: url)
        Safari.dismissButtonStyle = .close
        Safari.preferredControlTintColor = UIColor(.accent)
        return Safari
    }

    func updateUIViewController(_: SFSafariViewController, context _: UIViewControllerRepresentableContext<SafariView>) {}
}
