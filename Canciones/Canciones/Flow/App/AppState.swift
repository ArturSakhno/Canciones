//
//  AppState.swift
//  Canciones
//
//  Created by A S on 21.08.2022.
//

import Foundation

final class AppState: ObservableObject {
    @Published var isLoggedIn = false
    @Published var showBanner = false
    var notificationBannerConfiguration = NotificationBannerConfiguration.dummy
        
    init() {
        let token: AuthorizationToken? = ProtectedStorageService.shared.getData(forKey: StorageKeys.token.rawValue) 
        isLoggedIn = token != nil
    }
    
    @MainActor
    func showBanner(config: NotificationBannerConfiguration) {
        Task {
            notificationBannerConfiguration = config
            showBanner = true
            try? await Task.sleep(nanoseconds: 1_000_000_000 * config.secondsDisplay)
            showBanner = false
        }
    }
}
