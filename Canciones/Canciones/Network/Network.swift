//
//  Network.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

protocol NetworkType {
    func sendRequest<T: Decodable>(request: URLRequest, responseModel: T.Type) async -> Result<T, RequestError>
}

final class Network: NetworkType {
    var token: AuthorizationToken?
    
    func sendRequest<T: Decodable>(request: URLRequest, responseModel: T.Type) async -> Result<T, RequestError> {
        var mutableRequest = request
        do {
            if let token {
                mutableRequest.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
            } else {
                token = ProtectedStorageService.shared.getData(forKey: StorageKeys.token.rawValue)
                guard let token else { return .failure(.noResponse) }
                mutableRequest.addValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
            }
            let (data, response) = try await URLSession.shared.data(for: mutableRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                print("NETWORK NO RESPONSE")
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try decoder.decode(responseModel, from: data)
                    return .success(decodedResponse)
                } catch {
                    print("NETWORK DECODE \(error)")
                    return .failure(.decode)
                }
            default:
                print("NETWORK UNEXPECTED STATUS CODE")
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            print("NETWORK UNKNOWN")
            return .failure(.unknown)
        }
    }
}
