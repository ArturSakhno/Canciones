//
//  RequestError.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unexpectedStatusCode
    case unknown
    case cantRecieveToken
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No Response"
        case .unexpectedStatusCode:
            return "Unexpected Status Code"
        case .cantRecieveToken:
            return ""
        default:
            return "Unknown error"
        }
    }
}
