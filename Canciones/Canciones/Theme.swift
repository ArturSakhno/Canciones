//
//  Theme.swift
//  Canciones
//
//  Created by A S on 21.08.2022.
//

import SwiftUI

extension Image {
    static let theme = ImageTheme()
}

struct ImageTheme {
    let authorization = Authorization()
    let tab = Tab()
}

struct Authorization {
    let background = Image("authorization.background")
}

struct Tab {
    let home = Image(systemName: "house")
    let search = Image(systemName: "magnifyingglass")
    let profile = Image(systemName: "person")
}
