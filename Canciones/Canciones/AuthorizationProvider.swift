//
//  AuthorizationProvider.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import Foundation
import SwiftUI
import AuthenticationServices

final class AuthorizationProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
    
    @MainActor
    func start() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            start {
                continuation.resume()
            }
        }
    }

    private func start(callback: (() -> Void)?) {
        let state = NSUUID().uuidString
        let redirectURI = "canciones://callback"
        let clientId = "d1873dad152b40bea22bd7798030df79"
        let clientSecret = "213fa4841edc4faba36b163490768444"
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "state", value: state),
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "accounts.spotify.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { callback?(); return }
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "canciones") { url, error in
            guard let url else { callback?(); return }
            
            guard let code = url.absoluteString.slice(from: "code=", to: "&") else { callback?(); return }
            guard state == url.absoluteString.components(separatedBy: "state=")[safe: 1] else { callback?(); return}
            
            
            Task {
                let queryItems = [
                    URLQueryItem(name: "grant_type", value: "authorization_code"),
                    URLQueryItem(name: "code", value: code),
                    URLQueryItem(name: "redirect_uri", value: redirectURI),
                ]
                
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "accounts.spotify.com"
                urlComponents.path = "/api/token"
                urlComponents.queryItems = queryItems
                
                print(urlComponents)
                
                var request = URLRequest(url: urlComponents.url!)
                
                guard let authorization = (clientId + ":" + clientSecret).data(using: .utf8)?.base64EncodedString() else { callback?(); return }
                
                request.httpMethod = "POST"
                request.setValue("Basic \(authorization)", forHTTPHeaderField: "Authorization")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                let (data, _) = try await URLSession.shared.data(for: request)
                let stringData = String(data: data, encoding: .utf8)
                print(stringData!.utf8)
                
                callback?()
            }
        }
//        session.prefersEphemeralWebBrowserSession = true
        session.presentationContextProvider = self
        session.start()
    }
}
