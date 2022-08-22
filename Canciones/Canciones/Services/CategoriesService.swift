//
//  CategoriesService.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

protocol CategroiesServiceType {}

final class CategoriesService: CategroiesServiceType {
    let network = Network()
    
    func loadCategories() async throws -> [PlaylistCategoryItem] {
        guard let url = URL(string: "https://api.spotify.com/v1/browse/categories?limit=50") else { throw RequestError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        
        let response = await network.sendRequest(request: request, responseModel: PlaylistCategoriesResponse.self)
        
        switch response {
        case .failure(_):
            throw RequestError.noResponse
        case .success(let response):
            return response.categories.items
        }
    }
}
