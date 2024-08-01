//
//  HomeViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import Foundation

class HomeViewModel {
    var categories: [CategoryModel] = []
    var updateUI: (() -> Void)?
    
    func fetchRecipes() {
        let categoriesToFetch = ["BREAKFAST", "LUNCH", "DINNER"]
        fetchNextCategory(categories: categoriesToFetch, index: 0)
    }
    
    private func fetchNextCategory(categories: [String], index: Int) {
        guard index < categories.count else {
            self.updateUI?()
            return
        }
        
        let category = categories[index]
        print("Fetching recipes for category: \(category)")
        NetworkManager.shared.getRecipesByCategory(category: category) { [weak self] result in
            switch result {
            case .success(let recipes):
                let categoryModel = CategoryModel(name: category, recipes: recipes)
                self?.categories.append(categoryModel)
            case .failure(let error):
                print("Failed to fetch \(category) recipes: \(error.localizedDescription)")
            }
            self?.fetchNextCategory(categories: categories, index: index + 1)
        }
    }
    
    var recipes: [RecipeModel] {
        return categories.flatMap { $0.recipes }
    }
}
