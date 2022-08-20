//
//  Array+Extension.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
