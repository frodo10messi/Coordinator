//
//  AppCoordinator.swift
//  SpotiJ
//
//  Created by Jonathan Ramirez on 14.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    var isLoggedIn: Bool = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("dealloc \(self)")
    }

    func start() {
        if isLoggedIn {
            showMainView()
        } else {
            showAuthentication()
        }
    }
}

// MARK: - Handler Child and navigationController
extension AppCoordinator {

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        /// Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let loginViewController = fromViewController as? LoginViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(loginViewController.viewModel?.coordinator)
        }

        if let mainViewController = fromViewController as? MainViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(mainViewController.viewModel?.coordinator)
        }
    }
}

// MARK: - Handler Show Login or Main View
extension AppCoordinator {

    fileprivate func showMainView() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.parentCoordinator = self
        mainCoordinator.delegate = self
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }

    fileprivate func showAuthentication() {
        let authenticationCoordinator = AuthCoordinator(navigationController: navigationController)
        authenticationCoordinator.parentCoordinator = self
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        childCoordinators.append(authenticationCoordinator)
    }
}

// MARK: - Delegate Authentication Coordinator
extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func coordinatorDidAuthenticate(coordinator: AuthCoordinator) {
        print("showMainView")
        showMainView()
    }
}

// MARK: - Delegate Main Coordinator
extension AppCoordinator: MainCoordinatorDelegate {
    func coordinatorDidLogout(coordinator: MainCoordinator) {
        print("showAuthentication")
        showAuthentication()
    }
}
