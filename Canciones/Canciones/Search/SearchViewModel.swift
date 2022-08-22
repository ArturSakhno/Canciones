//
//  SearchViewModel.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var inputQuery = ""
    @Published var categories: [PlaylistCategoryItem] = []
    let service = CategoriesService()
    
    @MainActor
    func loadCategories() {
        guard categories.isEmpty else { return }
        Task {
            categories = (try? await service.loadCategories()) ?? []
        }
    }
}
