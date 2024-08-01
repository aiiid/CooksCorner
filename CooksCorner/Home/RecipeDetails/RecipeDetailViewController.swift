//
//  RecipeDetailViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    private let detailView = RecipeDetailView()
    private let viewModel: RecipeDetailViewModel
    
    override func loadView() {
        view = detailView
    }
    
    init(recipe: RecipeDetailModel) {
        self.viewModel = RecipeDetailViewModel(recipe: recipe)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.set(recipe: viewModel.recipe)
        setupDataSource()
        setupTargets()
        setupButtonActions()
        setupBindings()
    }
    
    private func setupDataSource() {
        detailView.ingredientsTableView.dataSource = self
        detailView.ingredientsTableView.delegate = self
        detailView.ingredientsTableView.register(IngridientCell.self, forCellReuseIdentifier: IngridientCell.reuseIdentifier)
    }
    
    private func setupTargets() {
        detailView.authorLabelButton.addTarget(self, action: #selector(authorTapped), for: .touchUpInside)
    }
    
    private func setupButtonActions() {
        detailView.likesAndBookmark.onSaveButtonTapped = { [weak self] in
            self?.bookMarkTapped()
        }
        
        detailView.likesAndBookmark.onLikeButtonTapped = { [weak self] in
            self?.likeTapped()
        }
    }
    
    private func setupBindings() {
        viewModel.onBookmarkStatusChanged = { [weak self] in
            guard let self = self else { return }
            self.detailView.set(recipe: self.viewModel.recipe)
        }
        
        viewModel.onAuthorFetched = { [weak self] authorDetail in
            guard let self = self else { return }
            let authorProfileViewModel = AuthorProfileViewModel(detailModel: authorDetail)
            let authorProfileViewController = AuthorProfileViewController(viewModel: authorProfileViewModel)
            self.navigationController?.pushViewController(authorProfileViewController, animated: true)
        }
    }
    
    @objc private func authorTapped() {
        viewModel.searchAuthorByName()
    }
    
    private func bookMarkTapped() {
        viewModel.bookmarkRecipe()
    }
    
    private func likeTapped() {
        viewModel.likeRecipe()
    }
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipe.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: IngridientCell.reuseIdentifier,
            for: indexPath
        ) as? IngridientCell else {
            return UITableViewCell()
        }
        
        let ingridient = viewModel.recipe.ingredients[indexPath.row]
        cell.configure(title: ingridient.ingredientName, detail: "\(ingridient.amount) \(ingridient.measureUnit)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
