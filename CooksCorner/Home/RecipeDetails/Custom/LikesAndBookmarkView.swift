//
//  LikesAndBookmarkView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

class LikesAndBookmarkView: UIView {
    private let heartIcon: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "heart"))
        image.tintColor = Constants.Colors.label
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let likedLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.label
        label.font = Constants.Fonts.smallText
        label.textAlignment = .left
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"),
                        for: .normal)
        button.tintColor = Constants.Colors.label
        return button
    }()
    
    init(likes: Int = 0) {
        super.init(frame: .zero)
        setupView(likes: likes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(likes: Int) {
        likedLabel.text = "\(likes) likes"
        
        [heartIcon, likedLabel, saveButton].forEach { addSubview($0) }
        
        heartIcon.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        likedLabel.snp.makeConstraints { make in
            make.leading.equalTo(heartIcon.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.width.equalTo(20)
        }
    }
}
