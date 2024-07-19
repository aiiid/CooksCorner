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
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .registration(let name, let email, let password):
            return .requestParameters(parameters: ["name": name, "email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}

