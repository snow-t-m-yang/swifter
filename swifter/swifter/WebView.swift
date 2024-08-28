//
//  WebView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context _: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}
