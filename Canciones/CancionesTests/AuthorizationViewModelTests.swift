//
//  AuthorizationViewModelTests.swift
//  CancionesTests
//
//  Created by A S on 21.08.2022.
//

import XCTest
@testable import Canciones

final class AuthorizationViewModelTests: XCTestCase {
    var viewModel: AuthorizationViewModel!
    let authorizationProvider = AuthorizationProviderMock()

    override func setUpWithError() throws {
        viewModel = AuthorizationViewModel(authorizationProvider: authorizationProvider)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoginTap() async {
        await viewModel.onLogin()
        XCTAssertEqual(authorizationProvider.startCallCount, 1)
    }
}
