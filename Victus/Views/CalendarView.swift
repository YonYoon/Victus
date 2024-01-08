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
                Text(viewModel.chatMessages.filter( {$0.role == .assistant } ).last?.content ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum justo leo, iaculis sed suscipit in, varius ut justo. Vivamus vel pretium nisi, eget dignissim libero. Maecenas porta vel ante nec tristique. Ut ullamcorper nulla leo, at tristique enim pellentesque eget. Proin vel interdum odio. Nullam malesuada odio vitae viverra blandit. Mauris massa dolor, finibus vel semper et, dapibus a sapien. Suspendisse est augue, mattis in sodales quis, blandit et erat. Curabitur ac maximus lacus.")
            }
            .navigationTitle("🍊 План питания")
            .padding()
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}


#Preview {
    CalendarView(viewModel: ViewModel())
}
