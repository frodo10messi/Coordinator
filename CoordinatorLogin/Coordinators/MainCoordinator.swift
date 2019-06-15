//
//  MainCoordinator.swift
//  CoordinatorLogin
//
//  Created by Jonathan Ramirez on 15.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func coordinatorDidLogout(coordinator: MainCoordinator)
}

class MainCoordinator: Coordinator {

    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    weak var delegate: MainCoordinatorDelegate?
    let mainViewcotroller = MainViewController()

    init(navigationController: UINavigationController ) {
        self.navigationController = navigationController
    }

    deinit {
        print("dealloc \(self)")
    }

    func start() {
        mainViewcotroller.viewModel = MainViewModel(coordinator: self)
        navigationController.setViewControllers([mainViewcotroller], animated: false)
    }
}

// MARK: - didLogout called by MainViewModel
extension MainCoordinator {
    func didLogout() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.coordinatorDidLogout(coordinator: self)
    }
}
