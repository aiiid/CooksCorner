//
//  LoginViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import Foundation

class LoginViewModel {
    
    var showAlert: ((String) -> Void)?
    
    func validateCredentials(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            showAlert?("Please fill in both fields.")
            completion(false)
            return
        }
        
        print("Validation succeeded: \(email), \(password)")
        sendLoginRequest(email: email, password: password, completion: completion)
    }


    private func sendLoginRequest(email: String, password: String, completion: @escaping (Bool) -> Void) {
        print("Sending login request for \(email)")
        NetworkManager.shared.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let loginResponse):
                print("Login succeeded, saving token")
                UserDefaults.standard.setValue(loginResponse.accessToken, forKey: "accessToken")
                completion(true)
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
                self?.showAlert?("Login failed: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

}
