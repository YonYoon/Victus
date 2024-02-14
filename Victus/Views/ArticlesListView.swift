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
                Section {
                    Image("fish")
                        .resizable()
                        .scaledToFill()
                        .padding(-10)
                    VStack(alignment: .leading) {
                        Text("Чем полезна рыба")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("И как она может изменить вашу жизнь.")
                            .font(.title3)
                    }
                }
                
                Section {
                    Image("beef")
                        .resizable()
                        .scaledToFill()
                        .padding(-10)
                    VStack(alignment: .leading) {
                        Text("Почему мясо надо есть с овощами")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Или же это овощи нужно есть с мясом?")
                            .font(.title3)
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
