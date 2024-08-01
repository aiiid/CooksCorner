//
//  AuthorProfileViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

class AuthorProfileViewController: UIViewController {
    private let profileView = AuthorProfileView()
    private let viewModel: AuthorProfileViewModel
    
    init(viewModel: AuthorProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
    }
    
    private func setupData() {
        profileView.set(profile: viewModel.profile)
    }
    
    private func setupCollectionView() {
        profileView.collectionView.dataSource = self
        profileView.collectionView.delegate = self
    }
}

extension AuthorProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRecipes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        let recipe = viewModel.recipe(at: indexPath.row)
        cell.configure(with: recipe)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Constants.Padding.medium
        let collectionViewSize = collectionView.frame.size.width - padding
        let itemWidth = (collectionViewSize - padding) / 2
        let itemHeight = (collectionViewSize - padding) / 1.6
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedID = indexPath.row
        
        NetworkManager.shared.getRecipeById(id: selectedID) { [weak self] result in
                   switch result {
                   case .success(let recipeDetail):
                       let detailViewController = RecipeDetailViewController(recipe: recipeDetail)
                       self?.navigationController?.pushViewController(detailViewController, animated: true)
                   case .failure(let error):
                       print("Failed to fetch recipe details: \(error.localizedDescription)")
//                       self?.contentView.showAlert(message: "Failed to fetch recipe details: \(error.localizedDescription)")
                   }
               }
    }
}
