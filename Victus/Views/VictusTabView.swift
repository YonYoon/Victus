//
//  ContentView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 04.10.2023.
//

import SwiftUI

struct VictusTabView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        TabView {
            CreateDietView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Diet")
                }
            
            ChatView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Nutritionist")
                }
            
            CalendarView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            ArticlesListView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Articles")
                }
        }
    }
}

#Preview {
    VictusTabView(viewModel: ViewModel())
}
