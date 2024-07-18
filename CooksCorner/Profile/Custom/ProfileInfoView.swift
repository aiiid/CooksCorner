//
//  ProfileInfoView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

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
        profile: ProfileModel = ProfileModel(
            name: "Default Name",
            avatarURL: "placeholder",
            bio: "Default Bio",
            recipesCount: 0,
            followersCount: 0,
            followingCount: 0,
            recipes: []
        )
    ) {
            super.init(frame: .zero)
            setupUI()
            set(profile: profile)
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
            make.top.equalTo(nameLabel.snp.bottom).offset(offsetSmall/2)
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
