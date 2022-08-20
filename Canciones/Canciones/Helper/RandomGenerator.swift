//
//  RandomGenerator.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import Foundation

struct RandomGenerator {
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
