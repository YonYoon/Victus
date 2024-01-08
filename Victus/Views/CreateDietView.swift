//
//  DietGenerationView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct CreateDietView: View {
    @ObservedObject var viewModel: ViewModel
        
    @State private var healthHistory = ""
    @State private var weight = 0.0
    @State private var height = 0
    @State private var goal = "Сбросить вес"
    @State private var budget = 0
    @State private var lifestyleBinding = "Сидячий"
    let lifestyle = ["Сидячий", "Умеренный", "Активный"]
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Ваши заболевания", text: $healthHistory)
                        .focused($isTextFieldFocused)
                } header: {
                    Text("История болезней")
                }
                
                Section {
                    TextField("Вес", value: $weight, format: .number, prompt: Text("Ваш вес"))
                        .keyboardType(.decimalPad)
                        .focused($isTextFieldFocused)
                        .overlay(alignment: .trailing) {
                            Text("кг")
                        }
                    
                    TextField("Рост", value: $height, format: .number, prompt: Text("Ваш рост"))
                        .keyboardType(.numberPad)
                        .focused($isTextFieldFocused)
                        .overlay(alignment: .trailing) {
                            Text("см")
                        }
                } header: {
                    Text("Индекс массы тела")
                }
                
                Section {
                    TextField("Цель", text: $goal)
                        .focused($isTextFieldFocused)
                } header: {
                    Text("Ваша цель")
                }
                
                Section {
                    Picker("Образ жизни", selection: $lifestyleBinding) {
                        ForEach(lifestyle, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextField("Бюджет", value: $budget, format: .currency(code: "KZT"))
                        .keyboardType(.decimalPad)
                        .focused($isTextFieldFocused)
                } header: {
                    Text("Ваш бюджет")
                }
                
                Section {
                    Button {
                        viewModel.currentInput = "Мой рост \(height)см и вес \(weight)кг. Мой образ жизни: \(lifestyleBinding). Моя цель это: \(goal). Мой месячный бюджет: \(budget) тенге. Создай для меня персональную диету для каждого дня недели, распиши какие продукты нужны для каждого блюда и сколько это будет стоить."
                        viewModel.sendChatMessage()
                    } label: {
                        Label("Создать", systemImage: "wand.and.stars")
                            .font(.title2)
                            .fontWeight(.medium)
                            .imageScale(.large)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Создание диеты")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Готово") {
                        isTextFieldFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    CreateDietView(viewModel: ViewModel())
}
