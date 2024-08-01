//
//  ProfileInfoView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

//
//  ProfileInfoView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileInfoView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = 44
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiboldText
        label.textColor = Constants.Colors.label
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
        return label
    }()
    
    let manageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Manage profile", for: .normal)
        button.titleLabel?.font = Constants.Fonts.regularText
        button.backgroundColor = Constants.Colors.secondary
        button.tintColor = Constants.Colors.primary
        button.layer.cornerRadius = 10
        return button
    }()
    
    init(
        profile: ProfileDetailModel = ProfileDetailModel(
            id: 0,
            name: "Default Name",
            bio: nil,
            imageUrl: nil,
            recipesAmount: 0,
            recipes: [],
            followerAmount: 0,
            followingsAmount: 0,
            savedRecipes: []
        )
    ) {
        super.init(frame: .zero)
        setupUI()
        set(profile: profile)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(profile: ProfileDetailModel) {
        if let imageUrl = profile.imageUrl, let url = URL(string: imageUrl), imageUrl.starts(with: "http") {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            profileImageView.image = UIImage(named: "placeholder")
        }
        nameLabel.text = profile.name
        bioLabel.text = profile.bio ?? "No bio available"
        
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        statsStackView.addArrangedSubview(createStatLabel(count: profile.recipesAmount, label: "Recipes"))
        statsStackView.addArrangedSubview(createStatLabel(count: profile.followerAmount, label: "Followers"))
        statsStackView.addArrangedSubview(createStatLabel(count: profile.followingsAmount, label: "Following"))
    }
    
    private func setupUI() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(statsStackView)
        addSubview(bioLabel)
        addSubview(manageButton)
        
        let padding = 20
        let offsetSmall = 10
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(88)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(28)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(offsetSmall)
            make.leading.trailing.equalToSuperview()
        }
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(offsetSmall / 2)
            make.leading.trailing.equalToSuperview()
        }
        
        manageButton.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(padding)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview()
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
