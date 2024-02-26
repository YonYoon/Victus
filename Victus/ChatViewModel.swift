//
//  ChatViewModel.swift
//  Victus
//
//  Created by Zhansen Zhalel on 19.10.2023.
//

import Foundation

class ViewModel: ObservableObject {
    static let content = "You are a professional nutritionist and diet maker, you help people to make them personal diets and give advices about health and healthy eating. You don't have information about other topics so you avoid to talk about them ALL times"
    
    @Published var chatMessages: [Message] = [Message(id: "", role: .system, content: content, createAt: Date())]
    @Published var currentInput: String = ""
    
    @Published var mealPlans = [MealPlan]()
    @Published var createdMealPlan = false
    
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
    
    func sendPrompt(message: String) async throws {
        let urlRequest = try openAIService.generateURLRequest(httpMethod: .post, message: message)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(Response.self, from: data)
            let calls = result.choices.first?.message.toolCalls
            for i in 0..<(calls?.count)! {
                guard let argumentData = calls?[i].function.arguments.data(using: .utf8) else {
                    print("guard let failed")
                    return
                }
                let mealPlan = try JSONDecoder().decode(MealPlan.self, from: argumentData)
                DispatchQueue.main.async {
                    self.mealPlans.append(mealPlan)
                }
                print(mealPlan)
            }
            DispatchQueue.main.async {
                self.createdMealPlan = true
            }
        } catch {
            print(error)
        }
    }
}


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
