//
//  CalendarView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var path = NavigationPath()
    @State private var generated = false
    @State private var isActive = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if generated {
                    ScrollView {
                        Text(viewModel.chatMessages.filter( {$0.role == .assistant } ).last?.content ?? "Ошибка")
                            .padding()

                    }
                } else {
                    Button("Создать план питания") {
                        isActive.toggle()
                    }
                }
            }
            .navigationTitle("🍊 План питания")
            .scrollBounceBehavior(.basedOnSize)
            .navigationDestination(isPresented: $isActive) {
                CreateDietView(viewModel: viewModel, isActive: $isActive, generated: $generated)
            }
            .toolbar {
                if generated {
                    Button("Создать план питания", systemImage: "arrow.triangle.2.circlepath") {
                        isActive = true
                    }
                }
            }
        }
    }
}


#Preview {
    CalendarView(viewModel: ViewModel())
}
