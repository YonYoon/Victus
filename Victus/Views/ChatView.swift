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
            ScrollView {
                ForEach(viewModel.messages.filter({$0.role != .system}), id:\.id) { message in
                    messageView(message: message)
                }
            }
            
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Button {
                    viewModel.sendMessage()
                } label: {
                    Label("Send", systemImage: "paperplane.fill")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .tint(.orange)
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
