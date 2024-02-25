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
            "Authorization": "Bearer \(Constants.openAIApiKey)"
        ]
        
        return try? await AF.request(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
    
    func sendStreamMessage(messages: [Message]) -> DataStreamRequest {
        let openAImessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAImessages, stream: true)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIApiKey)"
        ]
        
        return AF.streamRequest(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers)
    }
    
    func generateURLRequest(httpMethod: HTTPMethod, message: String) throws -> URLRequest {
        guard let url = URL(string: endpointURL) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        
        // Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        // Header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(Constants.openAIApiKey)", forHTTPHeaderField: "Authorization")
        
        // Body
        let systemMessage = FCMessage(role: "system", content: "Ты профессиональный нутрициолог. Ты должен отвечать только на русском языке.")
        let userMessage = FCMessage(role: "user", content: message)
        
        let dayOfTheWeek = Property(type: "string", description: "День недели, например понедельник, вторник, среда, четверг, пятница, суббота и воскресенье")
        let meal = Property(type: "string", description: "Прием пищи, то есть завтрак, либо обед, либо полдник, либо ужин")
        let food = Property(type: "string", description: "Короткое описание блюда, например омлет с овощами и цельнозерновый хлеб")
        let price = Property(type: "integer", description: "Цена блюда в тенге, например 500")
        
        let properties = Properties(dayOfTheWeek: dayOfTheWeek, meal: meal, food: food, price: price)
        let parameter = Parameter(type: "object", properties: properties, required: ["dayOfTheWeek", "meal", "food", "price"])
        let function = Function(name: "generate_meal_plan", description: "Создай персональную полезную диету на каждый день недели. Каждый день должен иметь уникальный завтрак, обед, полдник и ужин", parameters: parameter)
        
        let tool = Tool(type: "function", function: function)
        
        let payload = Payload(model: "gpt-3.5-turbo", messages: [systemMessage, userMessage], tools: [tool])
        
        let jsonData = try JSONEncoder().encode(payload)
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
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


// Function Calling
enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

// Request Models
struct Payload: Codable {
    let model: String
    let messages: [FCMessage]
    let tools: [Tool]
}

struct FCMessage: Codable {
    let role: String
    let content: String
}

struct Tool: Codable {
    let type: String
    let function: Function
}

struct Function: Codable {
    let name: String
    let description: String
    let parameters: Parameter
}

struct Parameter: Codable {
    let type: String
    let properties: Properties
    let required: [String]
}

struct Properties: Codable {
    let dayOfTheWeek: Property
    let meal: Property
    let food: Property
    let price: Property
}

struct Property: Codable {
    let type: String
    let description: String
}


// Response Models
struct Response: Codable {
    let choices: [Completion]
}

struct Completion: Codable {
    let message: ResponseMessage
}

struct ResponseMessage: Codable {
    let toolCalls: [Call]
}

struct Call: Codable {
    let function: FunctionResponse
}

struct FunctionResponse: Codable {
    let arguments: String
}

struct MealPlan: Codable, Hashable {
    let dayOfTheWeek: String
    let meal: String
    let food: String
    let price: Int
}
