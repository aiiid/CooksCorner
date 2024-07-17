//
//  CategoryNameCell.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//

import UIKit
import SnapKit

class CategoryNameCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.categoryName
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        titleLabel.textColor = isSelected ? .label : .secondaryLabel
    }
}
