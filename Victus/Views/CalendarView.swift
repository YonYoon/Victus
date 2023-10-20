//
//  CalendarView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var response: String?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(viewModel.messages.filter( {$0.role == .assistant } ).last?.content ?? "Sample text")
            }
            .padding()
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView(viewModel: ViewModel())
}
