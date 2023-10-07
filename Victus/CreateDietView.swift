//
//  DietGenerationView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct CreateDietView: View {
    @State private var healthHistory = ""
    @State private var weight = 0.0
    @State private var height = 0
    let goals = ["Weight loss", "Muscle gain", "Manage health condition", "Improve energy level", "General well-being"]
    @State private var goal = "Weight loss"
    @State private var budget = 0.0
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("Previous diseases", text: $healthHistory)
                            .focused($isTextFieldFocused)
                    } header: {
                        Text("Health History")
                    }
                    
                    Section {
                        TextField("Weight", value: $weight, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isTextFieldFocused)
                            .overlay(alignment: .trailing) {
                                Text("kg")
                            }
                        
                        TextField("Height", value: $height, format: .number, prompt: Text("Your height"))
                            .keyboardType(.numberPad)
                            .focused($isTextFieldFocused)
                            .overlay(alignment: .trailing) {
                                Text("cm")
                            }
                    } header: {
                        Text("Body Mass Index")
                    }
                    
                    Picker("Your goal", selection: $goal) {
                        ForEach(goals, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Section {
                        TextField("Budget", value: $budget, format: .currency(code: "KZT"))
                            .keyboardType(.decimalPad)
                            .focused($isTextFieldFocused)
                    } header: {
                        Text("Your budget")
                    }
                }
                .navigationTitle("Create Diet")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            isTextFieldFocused = false
                        }
                    }
                }
                
                Button {
                    // logic
                } label: {
                    Label("Create Diet", systemImage: "wand.and.stars")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .buttonBorderShape(.capsule)
                
                Spacer()
            }
        }
    }
}

#Preview {
    CreateDietView()
}
