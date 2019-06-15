//
//  LoginModelView.swift
//  CoordinatorLogin
//
//  Created by Jonathan Ramirez on 15.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

typealias TitleNavBar = (_ title: String) -> Void

protocol LoginModelViewModelType {
    var titleUpdated: TitleNavBar { get set }
}

class LoginViewModel: LoginModelViewModelType {

    var titleUpdated: TitleNavBar = {  _ in }

    weak var coordinator: AuthCoordinator?

    deinit {
        print("dealloc \(self)")
    }

// MARK: - Initialization
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Delegate Login View  Controller
extension LoginViewModel: LoginViewControllerDelegate {
    func didSuccessfullyLogin() {
        coordinator?.didAuthenticate()
    }
}
