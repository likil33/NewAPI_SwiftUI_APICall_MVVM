//
//  TabBar.swift
//  NewsApis_SwiftUI
//
//  Created by Santhosh K on 10/02/26.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Image("home")
                }
            SettingsView()
                .tabItem {
                    Image("settings")
                }
        }
    }
}

#Preview {
    TabBar()
}
