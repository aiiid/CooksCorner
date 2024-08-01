//
//  ProfileView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    private let profileInfo = ProfileInfoView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        return collectionView
    }()
    
    let myRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("My recipe", for: .normal)
        button.titleLabel?.font = Constants.Fonts.semiboldText
        button.setTitleColor(Constants.Colors.label, for: .normal)
        return button
    }()
    
     let savedRecipeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Saved recipe", for: .normal)
        button.titleLabel?.font = Constants.Fonts.semiboldText
        button.setTitleColor(Constants.Colors.gray, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(profile: ProfileDetailModel) {
        profileInfo.set(profile: profile)
    }
    
    func updateButtonState(isMyRecipeSelected: Bool) {
        setButtonState(button: myRecipeButton, isSelected: isMyRecipeSelected)
        setButtonState(button: savedRecipeButton, isSelected: !isMyRecipeSelected)
    }

    private func setButtonState(button: UIButton, isSelected: Bool) {
        UIView.transition(with: button, duration: 0.3, options: .transitionCrossDissolve) {
            button.setTitleColor(isSelected ? Constants.Colors.label : Constants.Colors.gray, for: .normal)
        }
    }
    
    
    private func setupUI() {
        backgroundColor = Constants.Colors.backgroundColor
        addSubview(profileInfo)
        addSubview(myRecipeButton)
        addSubview(savedRecipeButton)
        addSubview(collectionView)
        
        let padding = 20
        
        profileInfo.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(219)
        }
        
        myRecipeButton.snp.makeConstraints { make in
            make.top.equalTo(profileInfo.snp.bottom).offset(padding)
            make.leading.equalToSuperview().inset(padding)
            make.height.equalTo(44)
        }
        
        savedRecipeButton.snp.makeConstraints { make in
            make.top.equalTo(profileInfo.snp.bottom).offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(myRecipeButton.snp.bottom).offset(padding)
            make.leading.trailing.bottom.equalToSuperview().inset(padding)
        }
    }
}
