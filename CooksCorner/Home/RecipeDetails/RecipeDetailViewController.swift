//
//  RecipeDetailViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    private let detailView = RecipeDetailView()
    private let recipe: RecipeModel
    
    override func loadView() {
        view = detailView
    }
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.set(recipe: recipe)
        setupDataSource()
    }
    
    private func setupDataSource() {
        detailView.ingredientsTableView.dataSource = self
        detailView.ingredientsTableView.delegate = self
        detailView.ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicStyle")
    }
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // Replace with actual number of ingredients
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        cell.textLabel?.text = "Ingredient \(indexPath.row + 1)" // Replace with actual ingredient data
        cell.accessoryType = .checkmark
        return cell
    }
}
