//
//  ContentView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 04.10.2023.
//

import SwiftUI

struct VictusTabView: View {
    var body: some View {
        TabView {
            CreateDietView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Diet")
                }
            
            CalendarView()
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
    VictusTabView()
}
