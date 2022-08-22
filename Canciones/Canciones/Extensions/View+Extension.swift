//
//  View+Extension.swift
//  Canciones
//
//  Created by A S on 21.08.2022.
//

import SwiftUI

extension View {
    var anyView: some View {
        AnyView(self)
    }
}

extension View {
    @ViewBuilder func applyIf<T: View>(_ condition: @autoclosure () -> Bool, apply: (Self) -> T, else: ((Self) -> T)? = nil) -> some View {
        if condition() {
            apply(self)
        } else if `else` != nil {
            `else`!(self)
        } else {
            self
        }
    }
}
