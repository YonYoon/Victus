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
    
    private let days = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if generated && viewModel.createdMealPlan {
                    ScrollView {
                        HStack {
                            VStack(alignment: .leading) {
                                ForEach(days, id: \.self) { day in
                                    Text(day)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                    ForEach(viewModel.mealPlans, id: \.self) { mealPlan in
                                        if mealPlan.dayOfTheWeek.lowercased() == day.lowercased() {
                                            Text(mealPlan.meal.capitalized)
                                                .font(.title2)
                                            Text("Блюдо: \(mealPlan.food)")
                                            Text("Цена: \(mealPlan.price + 200) тг")
                                                .padding(.bottom)
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                } else if generated {
                    Text("Создание диеты...")
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
