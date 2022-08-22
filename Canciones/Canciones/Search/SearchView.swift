//
//  SearchView.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var path: [PlaylistCategoryItem] = []
    var body: some View {
        NavigationStack(path: $path) {
            List {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.categories) { item in
                        Button {
                            path.append(item)
                        } label: {
                            ZStack {
                                RandomGenerator.randomColor()
                                    .cornerRadius(8)
                                    .frame(height: 100)
                                Text(item.name)
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .listRowSeparator(.hidden)
            }
            
            .listStyle(.plain)
            .navigationDestination(for: PlaylistCategoryItem.self, destination: {
                Text($0.name)
            })
            .searchable(text: $viewModel.inputQuery)
            .navigationTitle("Search")
            .onAppear {
                viewModel.loadCategories()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
