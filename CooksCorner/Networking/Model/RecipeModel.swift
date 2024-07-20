//
//  RecipeModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//

import Foundation

struct CategoryModel {
    let name: String
    let recipes: [RecipeModel]
}

struct RecipeModel: Decodable {
    let id: Int
    let title: String
    let author: String
    let imageUrl: String
    let likesAmount: Int
    let bookmarksAmount: Int
}

struct RecipeDetailModel: Decodable {
    struct Ingredient: Decodable {
        let ingredientId: Int
        let ingredientName: String
        let amount: Int
        let measureUnit: String
    }
    
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
    let category: String
    let difficulty: String
    let cookingTimeMinutes: Int
    let author: String
    let isLiked: Bool
    let likesAmount: Int
    let isBookmarked: Bool
    let bookmarksAmount: Int
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, category, difficulty, author, isLiked, likesAmount, isBookmarked, bookmarksAmount, ingredients
        case imageUrl = "image_url"
        case cookingTimeMinutes = "cookingTimeMinutes"
    }
}


