//
//  SPJMainViewController.swift
//  SpotiJ
//
//  Created by Jonathan Ramirez on 14.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func mainViewControllerDidLogout()
}

class MainViewController: UIViewController {
    weak var delegate: MainViewControllerDelegate?
    var viewModel: MainViewModel?

    deinit {
        print("dealloc \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = viewModel

        self.view.backgroundColor = .lightGray
        self.title = "Main"

        setupViews()
     }

    func setupViews() {
        let logoutButton = UIButton(type: .custom)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle(" Logout ", for: .normal)
        logoutButton.backgroundColor = .red
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(didTapConnect(_:)), for: .touchUpInside)
        self.view.addSubview(logoutButton)

        logoutButton.widthAnchor.constraint(equalToConstant: 200)
        logoutButton.heightAnchor.constraint(equalToConstant: 44)
        logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive  = true
        logoutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive  = true
     }

    @objc func didTapConnect(_ button: UIButton) {
        delegate?.mainViewControllerDidLogout()
    }
}
