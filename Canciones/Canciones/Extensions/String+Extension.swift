//
//  String+Extension.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import Foundation

extension String {
    func slice(from: String, to: String = "") -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
