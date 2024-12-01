//
//  CardView.swift
//  swifter
//
//  Created by snow on 2024/11/30.
//

import SwiftUI

// consume the `saved` data
// render card in grid layout

struct CardView: View {
    let savedItem: Saved
    
    var body: some View {
        VStack {
            GroupBox{
                Text(savedItem.name ?? savedItem.url.absoluteString)
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.bottom, 5)
                WebView(url: savedItem.url)
                    .frame(height: 100)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1))
            } label: {
                Text("Saved")
            }
        }
        .padding()
        
    }
}

#Preview {
    CardView(savedItem: Saved.fakeItem())
}
