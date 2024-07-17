//
//  RecipeDetailView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//
import UIKit
import SnapKit
//import SDWebImage

class RecipeDetailView: UIView {
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.clear.cgColor]
            layer.locations = [0.0, 1.0]
            return layer
        }()
    
    let infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        return view
    }()
    
    let titleText: UILabel = {
        let text = UILabel()
        text.font = Constants.Fonts.recipeTitle
        text.textColor = .label
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let timeText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        text.text = "20-30 min"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let timeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "timer")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let descriptionLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProText-Semibold", size: 20)
        text.text = "Description"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let descriptionText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let titleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let timeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let descriptionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let reviewsLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProText-Semibold", size: 20)
        text.text = "Reviews"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let ingridientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
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
        titleText.text = recipe.name
        descriptionText.text = recipe.name + "decsriptiion should go here"
        mainImage.image = UIImage(named: recipe.thumbnail)
//        locationText.text = tour.location
//        
//        if let imageURL = URL(string: tour.thumbnail) {
//            mainImage.sd_setImage(with: imageURL, completed: nil)
//        } else {
//            mainImage.image = nil // Set a placeholder image if needed
//        }
    }
    
    private func setupView() {
        addSubview(mainImage)
        mainImage.layer.addSublayer(gradientLayer)
        addSubview(infoView)
        
        setupInfoView()
        
        mainImage.snp.makeConstraints { make in
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
        [timeIcon, timeText].forEach { timeStack.addArrangedSubview($0)}
        [titleText, timeStack].forEach { titleStack.addArrangedSubview($0)}
        [descriptionLabel, descriptionText].forEach { descriptionStack.addArrangedSubview($0)}
        
        [
            titleStack,
            timeStack,
            descriptionStack,
            reviewsLabel,
            ingridientsTableView
        ].forEach { infoView.addSubview($0) }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        timeIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        
        titleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.width.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview()
        }
        
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(titleStack.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
            
        }
        
        descriptionStack.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        reviewsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionStack.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        ingridientsTableView.snp.makeConstraints { make in
            make.top.equalTo(reviewsLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
