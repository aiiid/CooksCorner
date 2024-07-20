//
//  CategoryCell.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import UIKit
import SnapKit

protocol CategoryRecipeCellDelegate: AnyObject {
    func didSelectRecipe(_ recipe: RecipeModel)
}

class CategoryRecipeCell: UICollectionViewCell {
    weak var delegate: CategoryRecipeCellDelegate?
    
    private let recipeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        return collectionView
    }()
    
    private var recipes: [RecipeModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(recipeCollectionView)
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipeCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with category: CategoryModel) {
        recipes = category.recipes
        recipeCollectionView.reloadData()
    }
}

extension CategoryRecipeCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCell.reuseIdentifier,
            for: indexPath
        ) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        delegate?.didSelectRecipe(selectedRecipe)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = Constants.Padding.medium
        let collectionViewSize = collectionView.frame.size.width - padding
        let itemWidth = (collectionViewSize - padding) / 2
        let itemHeight = (collectionViewSize - padding) / 1.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
