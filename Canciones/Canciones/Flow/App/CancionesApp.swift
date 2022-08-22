//
//  CancionesApp.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import SwiftUI

@main
struct CancionesApp: App {
    @StateObject var router = Router()
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appState.isLoggedIn {
                    ContentView()
                        .transition(.scale)
                } else {
                    AuthorizationView()
                        .transition(.scale)
                }
            }
            .animation(.default, value: appState.isLoggedIn)
            .environmentObject(router)
            .environmentObject(appState)
            .notificationBanner(isPresented: $appState.showBanner, configuration: appState.notificationBannerConfiguration)
        }
    }
}
