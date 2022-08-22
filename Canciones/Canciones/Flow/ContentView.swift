//
//  ContentView.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image.theme.tab.home
                }
            
            SearchView()
                .tabItem {
                    Image.theme.tab.search
                }
            
            ProfileView()
                .tabItem {
                    Image.theme.tab.profile
                }
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
