//
//  ProfileViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import Foundation

class ProfileViewModel {
    var profile: ProfileDetailModel?
    var onProfileFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    var numberOfRecipes: Int {
        return profile?.recipes.count ?? 0
    }

    func recipe(at index: Int) -> RecipeModel? {
        return profile?.recipes[index]
    }

    func fetchUserProfile() {
        NetworkManager.shared.fetchUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.profile = profile
                self?.onProfileFetched?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
