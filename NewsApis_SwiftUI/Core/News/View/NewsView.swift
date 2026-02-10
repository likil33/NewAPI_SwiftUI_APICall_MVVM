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
                List(viewModel.newList){ news in
                    NewsListView(alrticles: news)
                }
            }
            .navigationTitle("News")
            .alert("Error", isPresented: .constant(false)) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Something went wrong")
            }
        }
    }
}

#Preview {
    NewsView()
}
