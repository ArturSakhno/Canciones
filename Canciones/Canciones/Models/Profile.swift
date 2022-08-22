//
//  Profile.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

struct Profile: Codable {
    let displayName: String
    let email: String
    let images: [Images]
}

struct Images: Codable {
    let url: String
}
