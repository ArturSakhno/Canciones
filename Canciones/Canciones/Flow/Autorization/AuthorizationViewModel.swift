//
//  AuthorizationViewModel.swift
//  Canciones
//
//  Created by A S on 21.08.2022.
//

import Foundation

final class AuthorizationViewModel: ObservableObject {
    @Published var animate = false
    
    private let authorizationProvider: AuthorizationProviderType
    private var appState: AppState?
    
    init(authorizationProvider: AuthorizationProviderType) {
        self.authorizationProvider = authorizationProvider
    }
    
    func onLoginTap() {
        Task {
            await onLogin()
        }
    }
    
    func setupAppState(_ appState: AppState) {
        self.appState = appState
    }
    
    @MainActor
    func onLogin() async {
        guard let appState else { return }
        do {
            try await authorizationProvider.start()
            appState.isLoggedIn = true
        } catch {
            appState.showBanner(config: NotificationBannerConfiguration(type: .error, title: "AuthError", subtitle: "AuthSubtitle"))
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                appState.showBanner(config: NotificationBannerConfiguration(type: .error, title: "11111", subtitle: "2222"))

            }
            print(error)
        }
    }
}
