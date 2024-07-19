//
//  HomeViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import Foundation

class HomeViewModel {
    var categories: [CategoryModel] = []
    
//    var showAlert: ((String) -> Void)?
    var updateUI: (() -> Void)?
    
    
    func fetchRecipes() {
        let categoriesToFetch = ["BREAKFAST", "LUNCH", "DINNER"]
        let group = DispatchGroup()
        
        var fetchedCategories: [CategoryModel] = []
        
        for category in categoriesToFetch {
            group.enter()
            print("Fetching recipes for category: \(category)")
            NetworkManager.shared.getRecipesByCategory(category: category) { result in
                switch result {
                case .success(let recipes):
                    let categoryModel = CategoryModel(name: category, recipes: recipes)
                    fetchedCategories.append(categoryModel)
                case .failure(let error):
                    //self?.showAlert?("Failed to fetch \(category) recipes: \(error.localizedDescription)")
                    print("Failed to fetch \(category) recipes: \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.categories = fetchedCategories
            self.updateUI?()
            print("Fetched categories: \(fetchedCategories)")
        }
    }
    
    func fetchRecipeById(id: Int) {
            NetworkManager.shared.getRecipeById(id: id) { [weak self] result in
                switch result {
                case .success(let recipe):
                    self?.updateRecipeDetails?(recipe)
                case .failure(let error):
                    self?.showAlert?("Failed to fetch recipe details: \(error.localizedDescription)")
                }
            }
        }

    
    var recipes: [RecipeModel] {
        return categories.flatMap { $0.recipes }
    }
}
