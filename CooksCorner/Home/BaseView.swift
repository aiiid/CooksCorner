//
//  BaseView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import UIKit
import SnapKit

class BaseView: UIView {
    lazy var headerContainer = UIView()
    
    lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    private let mainText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        
        let fullText = "Hi, Sarthak! UI Designer & Cook"
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [NSAttributedString.Key.font: Constants.Fonts.regular]
        )
        
        if let cooksCornerRange = fullText.range(of: "Sarthak") {
            let nsRange = NSRange(cooksCornerRange, in: fullText)
            attributedString.addAttribute(
                .font,
                value: Constants.Fonts.bold,
                range: nsRange
            )
        }
        
        label.attributedText = attributedString
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        addSubview(headerContainer)
        addSubview(mainCollectionView)
        
        configureHeaderContainer()
        
        headerContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Padding.medium)
            make.top.equalTo(headerContainer.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
        
        mainCollectionView.register(
            RecipeCell.self,
            forCellWithReuseIdentifier: RecipeCell.reuseIdentifier
        )
        
        mainCollectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.reuseIdentifier
        )
        
        mainCollectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: HeaderView.sectionHeaderElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier
        )
    }
    
    private func configureHeaderContainer() {
        headerContainer.addSubview(mainText)
        headerContainer.backgroundColor = Constants.Colors.primary
        
        mainText.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.Padding.medium)
            make.centerY.equalToSuperview()
            make.width.equalTo(Constants.Size.mainTextWidth)
        }
    }
}
