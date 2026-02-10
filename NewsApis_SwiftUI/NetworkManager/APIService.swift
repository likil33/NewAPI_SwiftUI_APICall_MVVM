//
//  APIService.swift
//  NewsApis_SwiftUI
//
//  Created by Santhosh K on 10/02/26.
//

import Foundation


enum HttpMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError:Error {
    case invlaidURL
    case serverError(Int)
    case decodingError
    case unknown
}

class APIService {
    
    static let shared = APIService()
    private init(){ }
    
    func request<T:Codable>(endpoint:String, method:HttpMethod = .get, headers: [String: String]? = nil, parameters: [String: Any]? = nil) async throws -> T {
        
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpresponse = response as? HTTPURLResponse, (200...299).contains(httpresponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
