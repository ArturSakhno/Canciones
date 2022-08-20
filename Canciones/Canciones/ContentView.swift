//
//  ContentView.swift
//  Canciones
//
//  Created by A S on 20.08.2022.
//

import SwiftUI

struct ContentView: View {
    let authProvider = AuthorizationProvider()
    var body: some View {
        VStack {
            Button {
                Task {
                    try? await authProvider.start()
                }
            } label: {
                Text("Hello")
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
