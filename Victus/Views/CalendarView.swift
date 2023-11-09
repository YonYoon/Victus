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
                VStack(alignment: .leading) {
                    Text("Понедельник")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    HStack {
                        Image("friedEggs")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Яичница")
                                .font(.title2)
                                .fontWeight(.medium)
                            Text("1000 тг")
                                .foregroundStyle(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                    Divider()
                    HStack {
                        Image("grilledChicken")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Курица с салатом")
                                .font(.title2)
                                .fontWeight(.medium)
                            Text("1200 тг")
                                .foregroundStyle(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                    Divider()
                    HStack {
                        Image("fish")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Рыба с овощами")
                                .font(.title2)
                                .fontWeight(.medium)
                            Text("1400 тг")
                                .foregroundStyle(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                }
                .padding()
                
                
                VStack(alignment: .leading) {
                    Text("Вторник")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    HStack {
                        Image("oatmeal")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Каша")
                                .font(.title2)
                                .fontWeight(.medium)
                            Text("800 тг")
                                .foregroundStyle(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                    Divider()
                    HStack {
                        Image("lentilSoup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Чечевичный суп")
                                .font(.title2)
                                .fontWeight(.medium)
                            Text("1100 тг")
                                .foregroundStyle(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                    Divider()
                    HStack {
                        Image("beef")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 70)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Говядина с брокколи")
                                .font(.title2)
                                .fontWeight(.medium)
                            Text("1500 тг")
                                .foregroundStyle(.secondary)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading)
                    }
                }
                .padding()
            }
            .navigationTitle("🍊 План питания")
            .padding(.top)
        }
    }
}

//                Text(viewModel.messages.filter( {$0.role == .assistant } ).last?.content ?? "Sample text")

#Preview {
    CalendarView(viewModel: ViewModel())
}
