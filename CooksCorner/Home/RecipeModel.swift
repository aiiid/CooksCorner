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

struct RecipeModel {
    let name: String
    let author: String
    let thumbnail: String
    let likes: Int
    let saves: Int
}
