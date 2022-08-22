//
//  Router.swift
//  Canciones
//
//  Created by A S on 21.08.2022.
//

import Foundation


final class Router: ObservableObject {
    @Published var path = [Route]()
    
    func backToRoot() {
        path.removeAll()
    }
    
    func back() {
        path.removeLast()
    }
}
