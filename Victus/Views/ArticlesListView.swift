//
//  ArticlesListView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct ArticlesListView: View {
    let articles = ArticlesModel.articles
    
    @State private var sheetDetail: Article?
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(articles) {article in
                    Section {
                        Button {
                            sheetDetail = article
                            showingSheet = true
                        } label: {
                            VStack {
                                Image(article.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .padding(-10)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(article.title)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.vertical)
                                .padding(.horizontal, 5)
                            }
                        }
                        .foregroundStyle(.primary)
                        .sheet(item: $sheetDetail) { article in
                            ArticleDetailView(article: article)
                        }
                    }
                }
            }
            .navigationTitle("📎 Статьи")
        }
    }
}

#Preview {
    ArticlesListView()
}
