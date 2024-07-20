//
//  RecipeDetailViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    private let detailView = RecipeDetailView()
    private let recipe: RecipeDetailModel
    
    override func loadView() {
        view = detailView
    }
    
    init(recipe: RecipeDetailModel) {
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
        setupTargets()
    }
    
    private func setupDataSource() {
        detailView.ingredientsTableView.dataSource = self
        detailView.ingredientsTableView.delegate = self
        detailView.ingredientsTableView.register(IngridientCell.self, forCellReuseIdentifier: IngridientCell.reuseIdentifier)
    }
    
    private func setupTargets() {
        detailView.authorLabelButton.addTarget(self, action: #selector(authorTapped), for: .touchUpInside)
    }
    
    @objc private func authorTapped() {
        let authourProfileViewController = AuthorProfileViewController()
        navigationController?.pushViewController(authourProfileViewController, animated: true)
    }
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngridientCell.reuseIdentifier, for: indexPath) as? IngridientCell else {
                  return UITableViewCell()
              }
       
        let ingridient = recipe.ingredients[indexPath.row]
        cell.configure(title: ingridient.ingredientName, detail: "\(ingridient.amount) \(ingridient.measureUnit)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
