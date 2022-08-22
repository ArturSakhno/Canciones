//
//  AuthorizationProviderMock.swift
//  CancionesTests
//
//  Created by A S on 21.08.2022.
//

import Foundation
@testable import Canciones

final class AuthorizationProviderMock: AuthorizationProviderType {
    var startCallCount = 0
    
    func start() async throws {
        startCallCount += 1
    }
}
