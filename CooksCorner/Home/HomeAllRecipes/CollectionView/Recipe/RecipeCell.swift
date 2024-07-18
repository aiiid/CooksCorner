//
//  RecipeCell.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//

//import SDWebImage
import UIKit

class RecipeCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(Constants.Size.cornerRadius/2)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.recipeCellTitle
        label.textAlignment = .left
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.smallText
        label.textAlignment = .left
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private let recipeStats = RecipeStatsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(contentStack)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(authorLabel)
        contentStack.addArrangedSubview(recipeStats)
        
        recipeStats.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(20)
        }
        
        contentStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.Padding.medium/2)
            make.leading.equalToSuperview().inset(Constants.Padding.small/2)
//            make.trailing.equalToSuperview().inset(Constants.Padding.large)
        }
    }
    
    public func configure(with recipe: RecipeModel) {
        titleLabel.text = recipe.name
        authorLabel.text = recipe.author
        recipeStats.configure(likes: recipe.likes, saves: recipe.saves)
        imageView.image = UIImage(named: recipe.thumbnail)
//
//        if let imageURL = URL(string: recipe.thumbnail) {
////            imageView.sd_setImage(with: imageURL, completed: nil)
//            print("should be")
//        } else {
//            imageView.image = nil // Set a placeholder image if needed
//        }
    }
}
