//
//  RecipeStats.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//

import UIKit

class RecipeStatsView: UIView {
    private let iconStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let heartIcon: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "heart"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let likedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.small
        label.textAlignment = .left
        return label
    }()
    
    private let saveIcon: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "bookmark"))
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let savedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.Fonts.small
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(iconStack)
        [heartIcon, likedLabel, saveIcon, savedLabel].forEach { iconStack.addArrangedSubview($0) }
        
        heartIcon.snp.makeConstraints { make in
            make.height.width.equalTo(28)
        }
        saveIcon.snp.makeConstraints { make in
            make.height.width.equalTo(28)
        }
        
        iconStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(likes: Int, saves: Int) {
           likedLabel.text = "\(likes)"
           savedLabel.text = "\(saves)"
       }
}