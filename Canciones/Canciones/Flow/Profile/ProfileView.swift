//
//  ProfileView.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            Section {
                if let profile = viewModel.profile {
                    VStack {
                        AsyncImage(url: URL(string: profile.images[safe: 0]?.url ?? ""))
                            .clipShape(Circle())
                            .frame(width: 300, height: 300)
                        Text(profile.displayName)
                        Text(profile.email)
                    }
                }
            }
            Section {
                Button("Logout") {
                    viewModel.onLogoutTap()
                }
                .onAppear {
                    viewModel.setupAppState(appState)
                    viewModel.loadProfile()
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
