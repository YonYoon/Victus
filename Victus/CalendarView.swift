//
//  CalendarView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 05.10.2023.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Day 1")
                Text("Day 2")
            }
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
}
