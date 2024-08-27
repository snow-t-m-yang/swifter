//
//  DocumentView.swift
//  swifter
//
//  Created by S on 2024/8/27.
//

import SwiftUI

struct DocView: View {
    @Environment(ModelData.self) var modelData

    var body: some View {
        NavigationStack {
            List {
                ForEach(modelData.docs) { doc in
                    NavigationLink {
                        VStack {
                            SafariView(url: URL(string: doc.urlString) ?? URL(string: "www.apple.com")!)
                                .ignoresSafeArea(.all)
                                .navigationBarBackButtonHidden(true)

                            Spacer()
                        }

                    } label: {
                        Text(doc.name)
                            .font(.title)
                            .padding(4)
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    DocView()
        .environment(ModelData())
}
