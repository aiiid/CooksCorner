//
//  AuthorProfileViewController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

class AuthorProfileViewController: UIViewController {
    private let profileView = ProfileView()
    private var profile: ProfileModel?
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
    }
    
    private func setupData() {
            // Dummy data
        let profile = ProfileModel(
            name: "Mr author",
            avatarURL: "placeholder.jpg",
            bio: "Author is aaaa a passionate chef who loves creating delicious dishes with flair.",
            recipesCount: 29,
            followersCount: 144,
            followingCount: 100,
            recipes: [
                RecipeModel(id: 1, title: "Egg Omelet", author: "Ainsley Harriott", imageUrl: "https://example.com/image1.jpg", likesAmount: 118, bookmarksAmount: 118),
                RecipeModel(id: 2, title: "Chicken Burger", author: "Ainsley Harriott", imageUrl: "https://example.com/image2.jpg", likesAmount: 118, bookmarksAmount: 118),
                RecipeModel(id: 3, title: "Onion Pizza", author: "Ainsley Harriott", imageUrl: "https://example.com/image3.jpg", likesAmount: 118, bookmarksAmount: 118),
                RecipeModel(id: 4, title: "Cherry Pastry", author: "Ainsley Harriott", imageUrl: "https://example.com/image4.jpg", likesAmount: 118, bookmarksAmount: 118)
            ])
            
            self.profile = profile
            profileView.set(profile: profile)
        }
    private func setupCollectionView() {
        profileView.collectionView.dataSource = self
        profileView.collectionView.delegate = self
    }
}

extension AuthorProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profile?.recipes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        if let recipe = profile?.recipes[indexPath.row] {
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
