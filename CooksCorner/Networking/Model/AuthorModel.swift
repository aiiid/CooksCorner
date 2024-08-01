//
//  AuthorModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 24/07/2024.
//

import Foundation

struct AuthorModel: Decodable {
    let id: Int
    let name: String
    let bio: String
    let imageUrl: String
}

struct ProfileDetailModel: Decodable {
    let id: Int
    let name: String
    let bio: String?
    let imageUrl: String?
    let recipesAmount: Int
    let recipes: [RecipeModel]
    let followerAmount: Int
    let followingsAmount: Int
    let savedRecipes: [RecipeModel]
    
    enum CodingKeys: String, CodingKey {
        case id, name, bio, recipes, recipesAmount, followerAmount, followingsAmount, savedRecipes
        case imageUrl = "image_url"
    }
}
