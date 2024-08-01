//
//  ProfileViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    private let profileView = ProfileView()
    private let viewModel = ProfileViewModel()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTargets()
        setupNavigationBar()
        setupBindings()
        viewModel.fetchUserProfile()
    }
    
    private func setupBindings() {
        viewModel.onProfileFetched = { [weak self] in
            guard let self = self else { return }
            self.profileView.set(profile: self.viewModel.profile!)
            self.profileView.collectionView.reloadData()
        }
        
        viewModel.onError = { errorMessage in
            // Handle error, possibly show an alert
            print("Failed to fetch profile: \(errorMessage)")
        }
    }
    
    private func setupCollectionView() {
        profileView.collectionView.dataSource = self
        profileView.collectionView.delegate = self
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.font = Constants.Fonts.semiboldTitle
        titleLabel.textColor = Constants.Colors.label
        
        let leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        let logoutButton = UIButton(type: .system)
        if let image = UIImage(named: "logout.png") {
            let resizedImage = image.resize(to: CGSize(width: 24, height: 24))
            logoutButton.setImage(resizedImage, for: .normal)
        }
        logoutButton.tintColor = Constants.Colors.gray
        
        let rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupTargets() {
        profileView.myRecipeButton.addTarget(self, action: #selector(myRecipeButtonTapped), for: .touchUpInside)
        profileView.savedRecipeButton.addTarget(self, action: #selector(savedRecipeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func myRecipeButtonTapped() {
        profileView.updateButtonState(isMyRecipeSelected: true)
        // Load my recipes data into collectionView
        print("My Recipes")
    }
    
    @objc private func savedRecipeButtonTapped() {
        profileView.updateButtonState(isMyRecipeSelected: false)
        // Load saved recipes data into collectionView
        print("Saved Recipes")
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRecipes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        if let recipe = viewModel.recipe(at: indexPath.row) {
            cell.configure(with: recipe)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Constants.Padding.medium
        let collectionViewSize = collectionView.frame.size.width - padding
        let itemWidth = (collectionViewSize - padding) / 2
        let itemHeight = (collectionViewSize - padding) / 1.6
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
