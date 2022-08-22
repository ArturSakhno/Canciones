//
//  AuthorizationView.swift
//  Canciones
//
//  Created by A S on 21.08.2022.
//

import SwiftUI

struct AuthorizationView: View {
    @StateObject var viewModel = AuthorizationViewModel(authorizationProvider: AuthorizationProvider())
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                viewModel.onLoginTap()
            } label: {
                Text("Loging with Spotify")
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .opacity(0.6)
                            .foregroundColor(.purple)
                    )
            }
            .offset(y: viewModel.animate ? 0 : 200)
            .opacity(viewModel.animate ? 1 : 0)
            .animation(.default, value: viewModel.animate)
        }
        .padding()
        .background(
            Image.theme.authorization.background
                .blur(radius: 2)
        )
        .onAppear {
            viewModel.setupAppState(appState)
            viewModel.animate.toggle()
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
