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
    let bio: String
    let image_url: String
    let recipesAmount: Int
    let recipes: [RecipeModel]
    let followerAmount: Int
    let followingsAmount: Int
}
