//
//  CategoryCell.swift
//  CooksCorner
//
//  Created by Ai Hawok on 14/07/2024.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCell"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: CategoryModel, isSelected: Bool) {
        titleLabel.text = category.name
        titleLabel.textColor = isSelected ? .red : .black // Change color based on selection
    }
}
