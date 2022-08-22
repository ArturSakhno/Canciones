//
//  NotificationBannerConfiguration.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

struct NotificationBannerConfiguration {
    let type: NotificationBannerType
    let title: String
    let subtitle: String
    
    static let dummy = NotificationBannerConfiguration(type: .error, title: "Title", subtitle: "Subtitle")
}

enum NotificationBannerType {
    case error
    case success
    case warning
}
