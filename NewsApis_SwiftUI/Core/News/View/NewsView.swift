//
//  NewsView.swift
//  NewsApis_SwiftUI
//
//  Created by Santhosh K on 10/02/26.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            Group{
                
                if let errorMessage = viewModel.errorMessage { 
                    Text(errorMessage) .foregroundColor(.red) .padding()
                }
                
                
                List(viewModel.newList){ news in
                    NewsListView(alrticles: news)
                }
                .task {
                    await viewModel.getNews()
                }
            }
            .navigationTitle("News")
            .alert("Error", isPresented: .constant(((viewModel.errorMessage?.isEmpty) != nil))) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "Something went wrong")
            }
        }
    }
}

#Preview {
    NewsView()
}
