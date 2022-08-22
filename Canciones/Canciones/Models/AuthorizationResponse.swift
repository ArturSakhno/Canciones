//
//  AuthorizationResponse.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

struct AuthorizationToken: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: CodingKey {
        case accessToken
        case refreshToken
    }
}
