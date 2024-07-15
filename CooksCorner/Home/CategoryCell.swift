//
//  CategoryCell.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCell"
    
    private let titleLabel = UILabel()
    private let recipeCollectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        recipeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recipeCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(recipeCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(8)
        }
        
        recipeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: CategoryModel) {
        titleLabel.text = category.name
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipes = category.recipes
        recipeCollectionView.reloadData()
    }
    
    private var recipes: [RecipeModel] = []
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 30
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
}
