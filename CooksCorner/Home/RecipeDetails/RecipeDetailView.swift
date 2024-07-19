//
//  RecipeDetailView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//
import UIKit
import SnapKit

class RecipeDetailView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.clear.cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let text = UILabel()
        text.font = Constants.Fonts.semiboldTitle
        text.textColor = Constants.Colors.label
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    private var cookingTime = CookingTimeView()
    private var difficultyLevel = DifficultyLevelView(level: .medium)
    private var descriptionText = DescriptionView()
    private var likesAndBookmark = LikesAndBookmarkView()
    
    let authorLabelButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Constants.Fonts.regularText
        button.setTitleColor(Constants.Colors.gray, for: .normal)
        return button
    }()
    
    private let ingridientsLabel: UILabel = {
        let text = UILabel()
        text.font = Constants.Fonts.recipeDescriptionTitle
        text.text = "Reviews"
        text.textColor = Constants.Colors.label
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let ingredientsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(recipe: RecipeModel) {
        titleLabel.text = recipe.title
        authorLabelButton.setTitle(recipe.author, for: .normal)
        
        var imageUrlString = recipe.imageUrl
               if imageUrlString.starts(with: "http://") {
                   imageUrlString = "https://" + imageUrlString.dropFirst(7)
               }
        
        if let imageURL = URL(string: imageUrlString) {
                    imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholder"))
                } else {
                    imageView.image = UIImage(named: "placeholder")
                }
    }
    
    private func setupView() {
        addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        addSubview(infoView)
        
        setupInfoView()
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
        }
        
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height * 0.2
        )
        
        infoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    private func setupInfoView() {
        
        [
            titleLabel,
            cookingTime,
            difficultyLevel,
            authorLabelButton,
            likesAndBookmark,
            descriptionText,
            ingridientsLabel,
            ingredientsTableView
        ].forEach { infoView.addSubview($0) }
        
        let padding = Constants.Padding.large
        let offsetSmall = Constants.Padding.small/2
        let offsetRegular = Constants.Padding.small
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(padding)
        }
        
        cookingTime.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(offsetSmall)
            make.leading.equalToSuperview().inset(padding)
            make.height.equalTo(22)
        }
        
        difficultyLevel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(padding)
            make.top.equalTo(cookingTime.snp.bottom).offset(offsetSmall)
        }
        
        authorLabelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(padding)
            make.top.equalTo(difficultyLevel.snp.bottom).offset(offsetSmall)
            make.height.equalTo(22)
        }
        
        likesAndBookmark.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(authorLabelButton.snp.bottom).offset(offsetRegular)
            make.height.equalTo(25)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(likesAndBookmark.snp.bottom).offset(offsetRegular)
        }
        
        ingridientsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(descriptionText.snp.bottom).offset(offsetRegular)
        }
        
        ingredientsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(ingridientsLabel.snp.bottom).offset(offsetSmall)
            make.bottom.equalToSuperview().inset(padding)
        }
    }
}
