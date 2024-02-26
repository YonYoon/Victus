//
//  ArticleDetailView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 26.02.2024.
//

import SwiftUI

struct ArticleDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    let article: Article
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image(article.imageName)
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text(article.description)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("📎 Статьи")
            .toolbar {
                Button("Закрыть", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    ArticleDetailView(article: ArticlesModel.articles.first!)
}
