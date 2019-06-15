//
//  AuthCoordinator.swift
//  SpotiJ
//
//  Created by Jonathan Ramirez on 14.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func coordinatorDidAuthenticate(coordinator: AuthCoordinator)
}

class AuthCoordinator: Coordinator {

    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    weak var delegate: AuthenticationCoordinatorDelegate?
    let loginViewController = LoginViewController()

    init(navigationController: UINavigationController ) {
        self.navigationController = navigationController
    }

    deinit {
        print("deallocing \(self)")
    }

    func start() {
        loginViewController.viewModel = LoginViewModel(coordinator: self)
        navigationController.setViewControllers([loginViewController], animated: false)
    }
}

// MARK: - didAuthenticate called by LoginViewModel
extension AuthCoordinator {

    func didAuthenticate() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.coordinatorDidAuthenticate(coordinator: self)
    }
}
