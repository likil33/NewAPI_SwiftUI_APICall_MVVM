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
    case decodingError(Error)
    case unknown
}

class APIService {
    
    static let shared = APIService()
    private let session:URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T:Codable>(endpoint:String, method:HttpMethod = .get, headers: [String: String]? = nil, parameters: [String: Any]? = nil) async throws -> T {
        
        guard var urlcomponent = URLComponents(string: endpoint) else {
            throw NetworkError.invlaidURL
        }
        
        var request:URLRequest
        
        if method == .get, let parameters {
            urlcomponent.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
            guard let url = urlcomponent.url else {throw NetworkError.invlaidURL}
            request = URLRequest(url: url)
        } else {
            guard let url = URL(string: endpoint) else {throw NetworkError.invlaidURL}
            request = URLRequest(url: url)
            if let parameters {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        request.httpMethod = method.rawValue
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpresponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpresponse.statusCode) else {
            throw NetworkError.serverError(httpresponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            print(try JSONSerialization.jsonObject(with: data))
            return try decoder.decode(T.self, from: data)
        }
        catch {
            throw NetworkError.decodingError(error)
        }
    }
}














/*
 
 
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

 
 
 */
