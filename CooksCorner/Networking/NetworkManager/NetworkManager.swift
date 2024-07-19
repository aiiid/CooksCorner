//
//  NetworkManager.swift
//  CooksCorner
//
//  Created by Ai Hawok on 19/07/2024.
//

import Foundation
import Moya

class NetworkManager {
    static let shared = NetworkManager()
    private let provider = MoyaProvider<APIService>()
    
    private init(){}
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    ) {
        provider.request(.login(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode == 200 {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: response.data)
                        completion(.success(loginResponse))
                    } else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        let error = NSError(domain: "", code: errorResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                        completion(.failure(error))
                    }
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func register(
            name: String,
            email: String,
            password: String,
            completion: @escaping (Result<String, Error>) -> Void
        ) {
            provider.request(.registration(name: name, email: email, password: password)) { result in
                switch result {
                case .success(let response):
                    let responseMessage = String(data: response.data, encoding: .utf8) ?? "Unknown response"
                    if response.statusCode == 200 {
                        completion(.success(responseMessage))
                    } else {
                        let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: responseMessage])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
