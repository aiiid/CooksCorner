//
//  LikesAndBookmarkView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

class LikesAndBookmarkView: UIView {
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        if let likeImage = UIImage(named: "like")?.withRenderingMode(.alwaysOriginal) {
            button.setImage(likeImage, for: .normal)
        }
        return button
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.label
        label.font = Constants.Fonts.smallText
        label.textAlignment = .left
        return label
    }()
    
    let bookMarkButton: UIButton = {
        let button = UIButton(type: .system)
        if let bookMarkImage = UIImage(named: "bookMark")?.withRenderingMode(.alwaysOriginal) {
            button.setImage(bookMarkImage, for: .normal)
        }
        return button
    }()
    
    private let bookMarkLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.label
        label.font = Constants.Fonts.smallText
        label.textAlignment = .right
        return label
    }()
    
    var onSaveButtonTapped: (() -> Void)?
    var onLikeButtonTapped: (() -> Void)?
    
    init(likes: Int = 0) {
        super.init(frame: .zero)
        setupView(likes: likes)
        bookMarkButton.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(likes: Int, bookMarks: Int, isBookmarked: Bool, isLiked: Bool) {
        likeLabel.text = "\(likes) likes"
        bookMarkLabel.text = "\(bookMarks)"
        
        let likeImageName = isLiked ? "likeFilled" : "like"
        if let likeImage = UIImage(named: likeImageName)?.withRenderingMode(.alwaysOriginal) {
            likeButton.setImage(likeImage, for: .normal)
        }
        
        
        let bookMarkImageName = isBookmarked ? "bookMarkFilled" : "bookMark"
        if let bookMarkImage = UIImage(named: bookMarkImageName)?.withRenderingMode(.alwaysOriginal) {
            bookMarkButton.setImage(bookMarkImage, for: .normal)
        }
    }
    
    @objc private func bookMarkButtonTapped() {
        onSaveButtonTapped?()
    }
    
    @objc private func likeButtonTapped() {
        onLikeButtonTapped?()
    }
    
    private func setupView(likes: Int) {
        likeLabel.text = "\(likes) likes"
        
        [likeButton, likeLabel, bookMarkButton, bookMarkLabel].forEach { addSubview($0) }
        
        likeButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        likeLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        bookMarkLabel.snp.makeConstraints { make in
            make.trailing.equalTo(bookMarkButton.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
        }
    }
}
