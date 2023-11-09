//
//  ChatView.swift
//  Victus
//
//  Created by Zhansen Zhalel on 19.10.2023.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
                    .font(.title)
                    .foregroundStyle(.accent)
                    .symbolRenderingMode(.multicolor)
                Text("Диетолог")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}), id:\.id) { message in
                    messageView(message: message)
                }
            }
            
            HStack {
                TextField("Спросите о диете...", text: $viewModel.currentInput)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Button {
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .imageScale(.large)
                        .font(.title2)
                }
                .tint(.accent)
            }
        }
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user { Spacer() }
            Text(message.content)
                .padding()
                .background(message.role == .user ? Color.orange.opacity(0.3) : Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            if message.role == .assistant { Spacer() }
        }
    }
}

#Preview {
    ChatView()
}
