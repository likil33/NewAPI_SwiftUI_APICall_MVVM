//
//  APIEndPoint.swift
//  NewsApis_SwiftUI
//
//  Created by Santhosh K on 10/02/26.
//

import Foundation



enum APIEndPoint {
    static let baseURL = "https://newsapi.org/v2/everything?q=tesla&from=2026-01-12&sortBy=publishedAt&apiKey="
    
    case news
    
    var url:String {
        switch self {
        case .news : return "\(APIEndPoint.baseURL)452aad4896e34de98e566f53f812a39a"
        }
    }
}

