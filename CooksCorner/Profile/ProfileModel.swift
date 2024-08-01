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

extension ProfileModel {
    init(from detailModel: ProfileDetailModel) {
        self.name = detailModel.name
        self.avatarURL = detailModel.imageUrl ?? "placeholder"
        self.bio = detailModel.bio ?? "No bio available"
        self.recipesCount = detailModel.recipesAmount
        self.followersCount = detailModel.followerAmount
        self.followingCount = detailModel.followingsAmount
        self.recipes = detailModel.recipes
    }
}
