//
//  RegistrationViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 10/07/2024.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    private let contentView = RegistrationView()
    private let viewModel = RegistrationViewModel()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    
    private func setupTargets() {
        contentView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        contentView.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    @objc func signUpTapped() {
        viewModel.validateCredentials(
            username: contentView.getUsername(),
            mail: contentView.getMail(),
            password: contentView.getPassword(),
            rePassword: contentView.getRePassword()) { result in
                switch result {
                case .success(let success):
                    self.contentView.showAlert(message: success, color: UIColor.green.cgColor)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let failure):
                    self.contentView.showAlert(message: failure.localizedDescription)
                    print(failure.localizedDescription)
                }
            }
    }
    
    @objc func signInTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
