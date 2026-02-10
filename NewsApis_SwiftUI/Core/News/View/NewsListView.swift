//
//  NewsListView.swift
//  NewsApis_SwiftUI
//
//  Created by Santhosh K on 10/02/26.
//


import SwiftUI



struct NewsListView:View {
    
    var alrticles:Articles
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string:alrticles.urlToImage ?? "")) { image in
                    image.resizable().clipShape(Circle())
                } placeholder: {
                    Circle().foregroundStyle(.gray)
                }
                .frame(width: 60, height: 60)
                
                VStack(alignment:.leading, spacing: 6) {
                    HStack {
                        Text(alrticles.author ?? "")
                            .bold()
                        Spacer()
                        Text(Date.now.formatted(date: .numeric, time: .omitted))
                            .font(.caption)
                    }
                    Text(alrticles.description ?? "")
                        .font(.subheadline)
                }
            }
        }
        .padding(.vertical, 6)
    }
}


//#Preview {
//    NewsListView()
//}

