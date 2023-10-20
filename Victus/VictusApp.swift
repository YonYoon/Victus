//
//  VictusApp.swift
//  Victus
//
//  Created by Zhansen Zhalel on 04.10.2023.
//

import SwiftUI

@main
struct VictusApp: App {
    @StateObject var openai = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            VictusTabView(viewModel: openai)
        }
    }
}
