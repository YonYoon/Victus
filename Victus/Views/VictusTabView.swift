//
//  ContentView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 04.10.2023.
//

import SwiftUI

struct VictusTabView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var chatViewModel: ViewModel
    
    var body: some View {
        TabView {
            CalendarView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Диета")
                }
            
            ChatView(viewModel: chatViewModel)
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Диетолог")
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
    VictusTabView(viewModel: ViewModel(), chatViewModel: ViewModel())
}
