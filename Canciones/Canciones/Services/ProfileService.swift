//
//  ProfileService.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

protocol ProfileServiceType {}

final class ProfileService: ProfileServiceType {
    let network = Network()
    
    func loadProfile() async throws -> Profile {
        guard let url = URL(string: "https://api.spotify.com/v1/me") else { throw RequestError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        
        let response = await network.sendRequest(request: request, responseModel: Profile.self)
        
        switch response {
        case .failure(_):
            throw RequestError.noResponse
        case .success(let profile):
            return profile
        }
    }
}
