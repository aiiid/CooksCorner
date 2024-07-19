//
//  APIService.swift
//  CooksCorner
//
//  Created by Ai Hawok on 19/07/2024.
//

import Foundation
import Moya

enum APIService {
    case login(email: String, password: String)
    case registration(name: String, email: String, password: String)
    case getRecipeByCategory(category: String)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://cookscorner-production-9502.up.railway.app/api/v1")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .registration:
            return "/registration"
        case .getRecipeByCategory(let category):
            return "/recipes/by-category/\(category)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .registration:
            return .post
        case .getRecipeByCategory:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .registration(let name, let email, let password):
            return .requestParameters(parameters: ["name": name, "email": email, "password": password], encoding: JSONEncoding.default)
        case .getRecipeByCategory:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .registration:
            return ["Content-type": "application/json"]
        case .getRecipeByCategory:
            if let token = UserDefaults.standard.string(forKey: "accessToken") {
                return ["Content-type": "application/json",
                        "Authorization": "Bearer \(token)"
                ]
            }
            return ["Content-type": "application/json"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var description: String {
           return "\(method.rawValue) \(baseURL)\(path)"
       }
}

