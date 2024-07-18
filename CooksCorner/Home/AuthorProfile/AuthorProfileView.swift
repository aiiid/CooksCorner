//
//  AuthorProfileView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit
import SnapKit

class AuthorProfileView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder.jpg")
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.boldText
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 17
        return stackView
    }()
    
    let bioLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularText
        label.textColor = Constants.Colors.textFaded
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = Constants.Fonts.regularText
        button.backgroundColor = Constants.Colors.primary
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(profile: ProfileModel) {
            profileImageView.image = UIImage(named: profile.avatarURL)
            nameLabel.text = profile.name
            bioLabel.text = profile.bio
            
            statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            statsStackView.addArrangedSubview(createStatLabel(count: profile.recipesCount, label: "Recipe"))
            statsStackView.addArrangedSubview(createStatLabel(count: profile.followersCount, label: "Followers"))
            statsStackView.addArrangedSubview(createStatLabel(count: profile.followingCount, label: "Following"))
        }
    
    private func setupUI() {
        backgroundColor = Constants.Colors.backgroundColor
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(statsStackView)
        addSubview(bioLabel)
        addSubview(followButton)
        addSubview(collectionView)
        
        let padding = 20
        let offsetSmall = 12
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(offsetSmall)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(offsetSmall)
            make.leading.trailing.equalToSuperview().inset(90)
        }
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(statsStackView.snp.bottom).offset(padding)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(padding)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview().inset(padding)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(followButton.snp.bottom).offset(padding)
            make.leading.trailing.bottom.equalToSuperview().inset(padding)
        }
    }
    
    private func createStatLabel(count: Int, label: String) -> UIStackView {
        let countLabel = UILabel()
        countLabel.text = "\(count)"
        countLabel.font = Constants.Fonts.semiboldTitle
        countLabel.textColor = Constants.Colors.label
        countLabel.textAlignment = .center
        
        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = UIFont(name: "Poppins-Regular", size: 12)!
        textLabel.textColor = Constants.Colors.textFaded
        textLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [countLabel, textLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }
}
