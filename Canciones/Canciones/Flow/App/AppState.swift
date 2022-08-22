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
    
    func showBanner(config: NotificationBannerConfiguration) {
        notificationBannerConfiguration = config
        showBanner = true
    }
}
