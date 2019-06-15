//
//  SPJLoginViewController.swift
//  SpotiJ
//
//  Created by Jonathan Ramirez on 14.06.19.
//  Copyright © 2019 HeadworkGames. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didSuccessfullyLogin()
}

class LoginViewController: UIViewController {
    weak var delegate: LoginViewControllerDelegate?
    var viewModel: LoginViewModel?

    deinit {
        print("dealloc \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = viewModel

        self.view.backgroundColor = .darkGray

        setupViews()
        setupBindings()
    }

    func setupViews() {
        let loginButton = UIButton(type: .custom)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle(" login... ", for: .normal)
        loginButton.backgroundColor = UIColor.init(red: (0x1D / 255.0), green: (0xB8 / 255.0), blue: (0x54 / 255.0), alpha: 1)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(didTapConnect), for: .touchUpInside)
        self.view.addSubview(loginButton)

        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive  = true
        loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive  = true
        loginButton.widthAnchor.constraint(equalToConstant: 200)
        loginButton.heightAnchor.constraint(equalToConstant: 44)
    }

    private func setupBindings() {
        viewModel?.titleUpdated = { [unowned self] title in
            self.title = title
        }
    }

    @objc func didTapConnect() {
        delegate?.didSuccessfullyLogin()
    }
}
