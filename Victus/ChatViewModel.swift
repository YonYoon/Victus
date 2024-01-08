//
//  ChatViewModel.swift
//  Victus
//
//  Created by Zhansen Zhalel on 19.10.2023.
//

import Foundation

//class ViewModel: ObservableObject {
//    @Published var messages: [Message] = [Message(id: "", role: .system, content: "You are a professional nutritionist and diet maker, you help people to make them personal diets and give advices about health and healthy eating. You don't have information about other topics so you avoid to talk about them ALL times", createAt: Date())]
//    
//    @Published var currentInput: String = ""
//    
//    private let openAIService = OpenAIService()
//    
//    func sendMessage() {
//        let newMessage = Message(id: "", role: .user, content: currentInput, createAt: Date())
//        messages.append(newMessage)
//        currentInput = ""
//        
//        Task {
//            let response = await openAIService.sendMessage(messages: messages)
//            guard let receivedOpenAIMessage = response?.choices.first?.message else {
//                print("Had no received message")
//                return
//            }
//            let receivedMessage = Message(id: "", role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createAt: Date())
//            await MainActor.run {
//                messages.append(receivedMessage)
//            }
//        }
//    }
//}

//extension ChatView {
class ViewModel: ObservableObject {
    static let content = "You are a professional nutritionist and diet maker, you help people to make them personal diets and give advices about health and healthy eating. You don't have information about other topics so you avoid to talk about them ALL times"
    @Published var chatMessages: [Message] = [Message(id: "", role: .system, content: content, createAt: Date())]
    
    @Published var currentInput: String = ""
    
    private let openAIService = OpenAIService()
    
    func sendChatMessage() {
        let newMessage = Message(id: UUID().uuidString, role: .user, content: currentInput, createAt: Date())
        chatMessages.append(newMessage)
        currentInput = ""
        
        openAIService.sendStreamMessage(messages: chatMessages).responseStreamString { [weak self] stream in
            guard let self = self else { return }
            switch stream.event {
            case .stream(let response):
                switch response {
                case .success(let string):
                    let streamResponse = self.parseStreamData(string)
                    streamResponse.forEach { newMessageResponse in
                        guard let messageContent = newMessageResponse.choices.first?.delta.content else {
                            return
                        }
                        guard let existingMessageIndex = self.chatMessages.lastIndex(where: {$0.id == newMessageResponse.id}) else {
                            let newMessage = Message(id: newMessageResponse.id, role: .assistant, content: messageContent, createAt: Date())
                            self.chatMessages.append(newMessage)
                            return
                        }
                        let newMessage = Message(id: newMessageResponse.id, role: .assistant, content: self.chatMessages[existingMessageIndex].content + messageContent, createAt: Date())
                        self.chatMessages[existingMessageIndex] = newMessage
                    }
                case .failure(_):
                    print("FAIL")
                }
            case .complete(_):
                print("COMPLETE")
            }
        }
    }
    
    func parseStreamData(_ data: String) -> [ChatStreamCompletionResponse] {
        let responseStrings = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
        let jsonDecoder = JSONDecoder()
        
        return responseStrings.compactMap { jsonString in
            do {
                guard let jsonData = jsonString.data(using: .utf8) else {
                    print("jsonData returned nil")
                    return nil
                }
                let streamResponse = try jsonDecoder.decode(ChatStreamCompletionResponse.self, from: jsonData)
                return streamResponse
            } catch {
                return nil
            }
        }
    }
}
//}


struct Message: Decodable {
    let id: String
    let role: SenderRole
    let content: String
    let createAt: Date
}

struct ChatStreamCompletionResponse: Decodable {
    let id: String
    let choices: [ChatStreamChoice]
}

struct ChatStreamChoice: Decodable {
    let delta: StreamContentItem
}

struct StreamContentItem: Decodable {
    let content: String
}
