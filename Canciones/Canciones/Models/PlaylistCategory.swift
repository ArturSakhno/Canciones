//
//  PlaylistCategory.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

struct PlaylistCategoriesResponse: Codable {
    let categories: PlaylistCategory
}

struct PlaylistCategory: Codable {
    let next: String?
    let total: Int
    let items: [PlaylistCategoryItem]
}

struct PlaylistCategoryItem: Codable, Identifiable, Hashable {
    let id: String
    let url: String
    let name: String
    let icons: [PlaylistCategoryIcon]
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "href"
        case name
        case icons
    }
}

struct PlaylistCategoryIcon: Codable, Hashable {
    let url: String
}
