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
