//
//  BasicStyleCell.swift
//  CooksCorner
//
//  Created by Ai Hawok on 17/07/2024.
//

import UIKit
import SnapKit

class IngridientCell: UITableViewCell {
    
    private let ingridientName: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularText
        label.textColor = Constants.Colors.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ingridientQuantity: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularText
        label.textColor = Constants.Colors.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupUI()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(ingridientName)
        contentView.addSubview(ingridientQuantity)
        
        ingridientName.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        ingridientQuantity.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String, detail: String) {
        ingridientName.text = title
        ingridientQuantity.text = detail
    }
}
