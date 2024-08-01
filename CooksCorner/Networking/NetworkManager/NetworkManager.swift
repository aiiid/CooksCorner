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
    
    //MARK: - Login requests
    
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
    
    //MARK: - Recipe requests
    
    func getRecipesByCategory(
        category: String,
        completion: @escaping (Result<[RecipeModel], Error>) -> Void
    ) {
        let target = APIService.getRecipeByCategory(category: category)
        print("Request URL: \(target.description)")
        
        provider.request(target) { result in
            switch result {
            case .success(let response):
                let responseMessage = String(data: response.data, encoding: .utf8) ?? "Unknown response"
                print("Response for category \(category): \(responseMessage)")
                do {
                    if response.statusCode == 200 {
                        let recipes = try JSONDecoder().decode([RecipeModel].self, from: response.data)
                        completion(.success(recipes))
                    } else {
                        let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: responseMessage])
                        print("Error for category \(category): \(responseMessage)")
                        completion(.failure(error))
                    }
                } catch {
                    print("Decoding error for category \(category): \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Request failure for category \(category): \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func getRecipeById(
        id: Int,
        completion: @escaping (Result<RecipeDetailModel, Error>) -> Void
    ) {
        provider.request(.getRecipeById(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let responseDataString = String(data: response.data, encoding: .utf8) ?? "Unable to convert data to string"
                    print("Response data: \(responseDataString)")
                    
                    let recipe = try JSONDecoder().decode(RecipeDetailModel.self, from: response.data)
                    completion(.success(recipe))
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    let errorMessage = String(data: response.data, encoding: .utf8) ?? "Unknown error"
                    let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func bookMarkRecipe(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
           provider.request(.bookMarkRecipe(id: id)) { result in
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
    
    func likeRecipe(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
           provider.request(.likeRecipe(id: id)) { result in
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
    
    //MARK: - Author requests
    
    func searchAuthorByName(name: String, completion: @escaping (Result<[AuthorModel], Error>) -> Void) {
            provider.request(.searchAuthor(name: name)) { result in
                switch result {
                case .success(let response):
                    do {
                        let authors = try JSONDecoder().decode([AuthorModel].self, from: response.data)
                        completion(.success(authors))
                    } catch {
                        let errorMessage = String(data: response.data, encoding: .utf8) ?? "Unknown error"
                        let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func getAuthorById(id: Int, completion: @escaping (Result<ProfileDetailModel, Error>) -> Void) {
        provider.request(.getAuthorById(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let author = try JSONDecoder().decode(ProfileDetailModel.self, from: response.data)
                    completion(.success(author))
                } catch {
                    let errorMessage = String(data: response.data, encoding: .utf8) ?? "Unknown error"
                    let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
