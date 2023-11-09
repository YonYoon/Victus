//
//  ContentView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 04.10.2023.
//

import SwiftUI

struct VictusTabView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var chatViewModel: ChatView.ViewModel
    
    var body: some View {
        TabView {
            CreateDietView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Создание")
                }
            
            ChatView(viewModel: chatViewModel)
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Диетолог")
                }
            
            CalendarView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Диета")
                }
            
            ArticlesListView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Статьи")
                }
        }
    }
}

#Preview {
    VictusTabView(viewModel: ViewModel(), chatViewModel: ChatView.ViewModel())
}
