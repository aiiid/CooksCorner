//
//  AuthorProfileViewModel.swift/Users/aihawok/Desktop/Screen Recording 2024-07-01 at 11.10.17 PM.mov
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import Foundation

class AuthorProfileViewModel {
    let profile: ProfileModel

    init(detailModel: ProfileDetailModel) {
        self.profile = ProfileModel(from: detailModel)
    }

    var numberOfRecipes: Int {
        return profile.recipes.count
    }

    func recipe(at index: Int) -> RecipeModel {
        return profile.recipes[index]
    }
}
