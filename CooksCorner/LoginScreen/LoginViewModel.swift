////
////  LoginViewModel.swift
////  CooksCorner
////
////  Created by Ai Hawok on 08/07/2024.
////
//
//import Foundation
//
//struct LoginResponse: Decodable {
//    let accessToken: String
//}
//
//struct Login: Encodable {
//    let username: String
//    let password: String
//}
//
//struct ErrorResponse: Decodable {
//    let path: String
//    let message: String
//    let statusCode: Int
//    let timestamp: String
//}
//
//
//class LoginViewModel {
//    
//    var showAlert: ((String) -> Void)?
//    
//    func validateCredentials(username: String?, password: String?, completion: @escaping (Bool) -> Void) {
//        guard let username = username, !username.isEmpty,
//              let password = password, !password.isEmpty else {
//            showAlert?("Please fill in both fields.")
//            completion(false)
//            return
//        }
//        
//        sendLoginRequest(username: username, password: password, completion: completion)
//    }
//    
//    private func sendLoginRequest(username: String, password: String, completion: @escaping (Bool) -> Void) {
//           NetworkManager.shared.login(username: username, password: password) { [weak self] result in
//               switch result {
//               case .success(let token):
//                   UserDefaults.standard.setValue(token, forKey: "jwtToken")
//                   completion(true)
//               case .failure(let error):
//                   self?.showAlert?("Login failed: \(error.localizedDescription)")
//                   completion(false)
//               }
//           }
//       }
//    
//    func testLogin() {
//        NetworkManager.shared.testLogin()
//    }
//}
