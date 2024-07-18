//
//  AuthorProfileViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import Foundation

class AuthorProfileViewModel {
    let profile: ProfileModel

    init(profile: ProfileModel) {
        self.profile = profile
    }

    var numberOfRecipes: Int {
        return profile.recipes.count
    }

    func recipe(at index: Int) -> RecipeModel {
        return profile.recipes[index]
    }
}
