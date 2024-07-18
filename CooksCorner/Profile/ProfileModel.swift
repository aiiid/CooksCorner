//
//  ProfileModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import Foundation

struct ProfileModel {
    let name: String
    let avatarURL: String
    let bio: String
    let recipesCount: Int
    let followersCount: Int
    let followingCount: Int
    let recipes: [RecipeModel]
}
