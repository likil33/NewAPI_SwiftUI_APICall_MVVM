//
//  NewsViewModel.swift
//  NewsApis_SwiftUI
//
//  Created by Santhosh K on 10/02/26.
//

import Foundation


class NewsViewModel:ObservableObject {
    
    @Published var newList:[Articles] = []
    @Published var errorMessage: String?
    
    init() {
//        Task {await self.getNews()}
    }
    
    
    @MainActor
    func getNews() async {
        do {
            let response:NewsModelRes = try await APIService.shared.request(endpoint: APIEndPoint.news.url)
            self.newList = response.articles ?? []
            print(self.newList.count)
        }
        catch {
            self.errorMessage = "Request failed:\(error)"
        }
    }
}







/*
 
 import Foundation


 class NewsViewModel:ObservableObject {
     
     @Published var newList:[Articles] = []
     
     init() {
         Task {await self.getNews()}
     }
     
     
     @MainActor
     func getNews() async {
         do {
             let response:NewsModelRes = try await APIService.shared.request(endpoint: APIEndPoint.news.url)
             self.newList = response.articles ?? []
             print(self.newList.count)
         }
         catch {
             print("Request failed:\(error)")
         }
     }
 }


 //POST
 //let response:NewsModelRes = try await APIService.shared.request(endpoint: APIEndPoint.news.url, method: .put, headers: nil, parameters: [:])

 
 
 */
