//
//  RegistrationViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 10/07/2024.
//

import Foundation

class RegistrationViewModel {
    func validateCredentials(
        username: String?,
        mail: String?,
        password: String?,
        rePassword: String?,
        completion: @escaping (Result<String, Error>) -> Void) {
            guard let username = username, !username.isEmpty,
                  let mail = mail, !mail.isEmpty,
                  let password = password, !password.isEmpty,
                  let rePassword = rePassword, !rePassword.isEmpty
            else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "All fields are required."])
                completion(.failure(error))
                return
            }
            if password != rePassword {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Passwords should match"])
                completion(.failure(error))
                return
            }
            NetworkManager.shared.register(name: "John Doe", email: "john@example.com", password: "Password123!") { result in
                switch result {
                case .success(let message):
                    print("Registration successful: \(message)")
                    completion(.success((message)))
                case .failure(let error):
                    print("Registration failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }

            
        }
}
