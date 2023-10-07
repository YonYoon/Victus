//
//  ArticlesListView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct ArticlesListView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Article 1")
                Text("Article 2")
            }
            .navigationTitle("Articles")
        }
    }
}

#Preview {
    ArticlesListView()
}
