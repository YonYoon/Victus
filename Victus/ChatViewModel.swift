//
//  ChatViewModel.swift
//  Victus
//
//  Created by Zhansen Zhalel on 19.10.2023.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var messages: [Message] = [Message(id: UUID(), role: .system, content: "You are a professional nutritionist and diet maker, you help people to make them personal diets and give advices about health and healthy eating. You don't have information about other topics so you avoid to talk about them ALL times", createAt: Date())]
    
    @Published var currentInput: String = ""
    
    private let openAIService = OpenAIService()
    
    func sendMessage() {
        let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
        messages.append(newMessage)
        currentInput = ""
        
        Task {
            let response = await openAIService.sendMessage(messages: messages)
            guard let receivedOpenAIMessage = response?.choices.first?.message else {
                print("Had no received message")
                return
            }
            let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
            await MainActor.run {
                messages.append(receivedMessage)
            }
        }
    }
}


struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
