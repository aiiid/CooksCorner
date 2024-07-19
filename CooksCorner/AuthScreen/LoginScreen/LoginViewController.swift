//
//  LoginViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit

class LoginViewController: UIViewController {
    private let contentView = LoginView()
    private let viewModel = LoginViewModel()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        bindModel()
    }

    
    private func setupTargets() {
        contentView.signInButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        contentView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
    }
    
    private func bindModel() {
        viewModel.showAlert = { [weak self] message in
            self?.contentView.showAlert(message: message)
        }
    }
    
    @objc private func loginTapped() {
        viewModel.validateCredentials(
            email: contentView.emailField.textField.text,
            password: contentView.passwordField.textField.text
        ){ [weak self] success in
            if success {
                self?.showHomeScreen()
            }
        }
    }
    
    @objc private func registerTapped() {
        let registrationViewController = RegistrationViewController()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    private func showHomeScreen() {
        let tabBarController = TabBarController()
        guard let window = view.window else { return }
        
        window.rootViewController = tabBarController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
