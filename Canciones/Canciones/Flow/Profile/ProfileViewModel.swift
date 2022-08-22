//
//  ProfileViewModel.swift
//  Canciones
//
//  Created by A S on 22.08.2022.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var profile: Profile?
    
    var appState: AppState?
    let profileService = ProfileService()
    
    func setupAppState(_ appState: AppState) {
        self.appState = appState
    }
    
    @MainActor
    func loadProfile() {
        guard profile == nil else { return }
        Task {
            profile = try? await profileService.loadProfile()
        }
    }
    
    func onLogoutTap() {
        Task {
            await onLogout()
        }
    }
    
    @MainActor
    func onLogout() async {
        guard let appState else { return }
        ProtectedStorageService.shared.removeValueForKey(StorageKeys.token.rawValue)
        appState.isLoggedIn = false
    }
}
