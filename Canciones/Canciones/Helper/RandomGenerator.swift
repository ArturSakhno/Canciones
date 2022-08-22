//
//  RandomGenerator.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import SwiftUI

struct RandomGenerator {
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
    
    static func randomColor() -> Color {
        return Color(UIColor.random())
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1.0
        )
    }
}
