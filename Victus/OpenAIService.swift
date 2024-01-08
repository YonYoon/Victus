//
//  OpenAIService.swift
//  Victus
//
//  Created by Zhansen Zhalel on 19.10.2023.
//

import Foundation
import Alamofire

class OpenAIService {
    private let endpointURL = "https://api.openai.com/v1/chat/completions"
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAImessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAImessages, stream: false)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIApiKey!)"
        ]
        
        return try? await AF.request(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
    
    func sendStreamMessage(messages: [Message]) -> DataStreamRequest {
        let openAImessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAImessages, stream: true)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIApiKey!)"
        ]
        
        return AF.streamRequest(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers)
    }
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    let stream: Bool
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
