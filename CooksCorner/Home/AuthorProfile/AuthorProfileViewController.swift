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
                name: "Ainsley Harriott",
                avatarURL: "placeholder.jpg",
                bio: "Ainsley Denzil Dubriel Harriott MBE is an English chef and television presenter. He is known for his BBC cooking",
                recipesCount: 29,
                followersCount: 144,
                followingCount: 100,
                recipes: [
                    RecipeModel(name: "Egg Omlet", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118),
                    RecipeModel(name: "Chicken Burger", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118),
                    RecipeModel(name: "Onion Pizza", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118),
                    RecipeModel(name: "Cheery Pastry", author: "Ainsley Harriott", thumbnail: "placeholder.jpg", likes: 118, saves: 118)
                ]
            )
            
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
