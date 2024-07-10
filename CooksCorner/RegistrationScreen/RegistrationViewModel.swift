//
//  RegistrationViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 10/07/2024.
//

import Foundation

class RegistrationViewModel {
    //check if all textfield are filled
//    somehow idk how
    
    func validateCredentials(
        username: String?,
        mail: String?,
        password: String?,
        rePassword: String?,
        completion: @escaping (Result<Void, Error>) -> Void) {
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
            
            completion(.success(()))
        }
   
}
