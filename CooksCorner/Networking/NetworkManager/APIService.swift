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
    case getRecipeById(id: Int)
    case bookMarkRecipe(id: Int)
    case likeRecipe(id: Int)
    case searchAuthor(query: String)
    case getAuthorById(id: Int)
    case searchAuthor(name: String)
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
        case .getRecipeById(let id):
            return "/recipes/\(id)"
        case .bookMarkRecipe(let id):
            return "/recipes/\(id)/bookmark"
        case .likeRecipe(let id):
            return "/recipes/\(id)/like"
        case .searchAuthor:
            return "/users/search"
        case .getAuthorById(let id):
            return "/users/\(id)"
                }
        }
    
    var method: Moya.Method {
        switch self {
        case .login, .registration, .bookMarkRecipe, .likeRecipe:
            return .post
        case .getRecipeByCategory, .getRecipeById, .searchAuthor, .getAuthorById:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .registration(let name, let email, let password):
            return .requestParameters(parameters: ["name": name, "email": email, "password": password], encoding: JSONEncoding.default)
        case .bookMarkRecipe(let id), .likeRecipe(let id):
            return .requestPlain
        case .getRecipeByCategory, .getRecipeById, .getAuthorById:
            return .requestPlain
        case .searchAuthor(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .registration:
            return ["Content-type": "application/json"]
        case .getRecipeByCategory, .getRecipeById, .searchAuthor, .getAuthorById, .bookMarkRecipe, .likeRecipe:
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

