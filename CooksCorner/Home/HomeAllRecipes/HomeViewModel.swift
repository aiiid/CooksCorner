//
//  HomeViewModel.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import Foundation

class HomeViewModel {
    let categories: [CategoryModel] = [
        CategoryModel(name: "Breakfast", recipes: [
            RecipeModel(name: "Egg Omlet", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118),
            RecipeModel(name: "Pancakes", author: "Jamie Oliver", thumbnail: "placeholder.jpg", likes: 200, saves: 150),
            RecipeModel(name: "Pancakes", author: "Jamie Oliver", thumbnail: "placeholder.jpg", likes: 200, saves: 150),
            RecipeModel(name: "Pancakes", author: "Jamie Oliver", thumbnail: "placeholder.jpg", likes: 200, saves: 150),
            RecipeModel(name: "Pancakes", author: "Jamie Oliver", thumbnail: "placeholder.jpg", likes: 200, saves: 150)
        ]),
        CategoryModel(name: "Lunch", recipes: [
            RecipeModel(name: "Chicken Burger", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118),
            RecipeModel(name: "Salad", author: "Gordon Ramsay", thumbnail: "placeholder.jpg", likes: 180, saves: 140)
        ]),
        CategoryModel(name: "Dinner", recipes: [
            RecipeModel(name: "Onion Pizza", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118),
            RecipeModel(name: "Steak", author: "Nigella Lawson", thumbnail: "placeholder.jpg", likes: 250, saves: 200)
        ])
    ]
    
    var recipes: [RecipeModel] {
        return categories.flatMap { $0.recipes }
    }
}
