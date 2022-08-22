//
//  AuthorizationProvider.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import Foundation
import SwiftUI
import AuthenticationServices

protocol AuthorizationProviderType {
    func start() async throws
}

final class AuthorizationProvider: NSObject, ASWebAuthenticationPresentationContextProviding, AuthorizationProviderType {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
    
    @MainActor
    func start() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>)  in
            start { (result: Result<Void, AuthorizationError>)  in
                switch result {
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                case .success:
                    continuation.resume()
                }
            }
        }
    }
    
    
    private func start(callback: @escaping (Result<Void, AuthorizationError>) -> Void) {
        let state = NSUUID().uuidString
        let redirectURI = "canciones://callback"
        let clientId = "d1873dad152b40bea22bd7798030df79"
        let clientSecret = "213fa4841edc4faba36b163490768444"
        let scope = "user-read-private user-read-email user-library-modify user-library-read"
        
        let queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "scope", value: scope),
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "accounts.spotify.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            callback(.failure(.wrongUrl))
            return
        }
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "canciones") { url, error in
            guard let url else {
                callback(.failure(.wrongUrl))
                return
            }
            
            guard let code = url.absoluteString.slice(from: "code=", to: "&") else {
                callback(.failure(.extractCode))
                return
            }
            guard state == url.absoluteString.components(separatedBy: "state=")[safe: 1] else {
                callback(.failure(.extractState))
                return
            }
            
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
                
                guard let authorization = (clientId + ":" + clientSecret).data(using: .utf8)?.base64EncodedString() else {
                    callback(.failure(.extractAuthorization))
                    return
                }
                
                request.httpMethod = "POST"
                request.setValue("Basic \(authorization)", forHTTPHeaderField: "Authorization")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                ProtectedStorageService.shared.save(data, forKey: StorageKeys.token.rawValue)
                
                print(String(decoding: data, as: UTF8.self))
                callback(.success(()))
            }
        }
        //        session.prefersEphemeralWebBrowserSession = true
        session.presentationContextProvider = self
        session.start()
    }
}

enum AuthorizationError: Error {
    case wrongUrl
    case extractCode
    case extractState
    case extractAuthorization
}
