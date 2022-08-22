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
                mutableRequest.addValue("token \(token)", forHTTPHeaderField: "Authorization")
            } else {
                token = ProtectedStorageService.shared.getData(forKey: StorageKeys.token.rawValue)
            }
            let (data, response) = try await URLSession.shared.data(for: mutableRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decodedResponse)
                } catch {
                    return .failure(.decode)
                }
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
