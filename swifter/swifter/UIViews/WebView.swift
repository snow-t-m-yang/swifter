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
    @Binding var isWebViewLoading: Bool
    @Binding var currentURL: URL?
    
    // We need to initialize it since there are optional arguments
    init(url: URL,
         isWebViewLoading: Binding<Bool> = .constant(false),
         currentURL: Binding<URL?> = .constant(nil)) {
        self.url = url
        self._isWebViewLoading = isWebViewLoading
        self._currentURL = currentURL
    }


    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
            parent.isWebViewLoading = true
        }

        func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
            parent.isWebViewLoading = false
            parent.currentURL = webView.url
        }

        func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
            parent.isWebViewLoading = false
        }
    }
}
