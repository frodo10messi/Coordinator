//
//  MainModelVeiw.swift
//  CoordinatorLogin
//
//  Created by Jonathan Ramirez on 15.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

class MainViewModel: NSObject {

    weak var coordinator: MainCoordinator?

    deinit {
        print("dealloc \(self)")
    }

    // MARK: - Initialization
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Delegate Main View  Controller
extension MainViewModel: MainViewControllerDelegate {
    func mainViewControllerDidLogout() {
        coordinator?.didLogout()
    }
}
