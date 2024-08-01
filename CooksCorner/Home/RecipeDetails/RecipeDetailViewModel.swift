//
//  RecipeDetailViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 01/08/2024.
//

import Foundation

class RecipeDetailViewModel {
    private(set) var recipe: RecipeDetailModel
    var onBookmarkStatusChanged: (() -> Void)?
    var onAuthorFetched: ((ProfileDetailModel) -> Void)?
    
    init(recipe: RecipeDetailModel) {
        self.recipe = recipe
    }

    func bookmarkRecipe() {
        NetworkManager.shared.bookMarkRecipe(id: recipe.id) { [weak self] result in
            switch result {
            case .success:
                print("Recipe bookmarked successfully")
                self?.fetchUpdatedRecipeDetails()
            case .failure(let error):
                print("Failed to bookmark recipe: \(error.localizedDescription)")
            }
        }
    }
    
    func likeRecipe() {
        NetworkManager.shared.likeRecipe(id: recipe.id) { [weak self] result in
            switch result {
            case .success:
                print("Recipe liked successfully")
                self?.fetchUpdatedRecipeDetails()
            case .failure(let error):
                print("Failed to like recipe: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchUpdatedRecipeDetails() {
        NetworkManager.shared.getRecipeById(id: recipe.id) { [weak self] result in
            switch result {
            case .success(let updatedRecipe):
                self?.recipe = updatedRecipe
                self?.onBookmarkStatusChanged?()
            case .failure(let error):
                print("Failed to fetch updated recipe details: \(error.localizedDescription)")
            }
        }
    }
    
    func searchAuthorByName() {
        NetworkManager.shared.searchAuthorByName(name: recipe.author) { [weak self] result in
            switch result {
            case .success(let authors):
                guard let author = authors.first else {
                    print("No authors found")
                    return
                }
                self?.fetchAuthorDetails(by: author.id)
            case .failure(let error):
                print("Failed to search author: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchAuthorDetails(by id: Int) {
        NetworkManager.shared.getAuthorById(id: id) { [weak self] result in
            switch result {
            case .success(let authorDetail):
                self?.onAuthorFetched?(authorDetail)
            case .failure(let error):
                print("Failed to fetch author details: \(error.localizedDescription)")
            }
        }
    }
}
