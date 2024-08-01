//
//  DescriptionView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

class DescriptionView: UIView {
    
    private let descriptionLabel: UILabel = {
        let text = UILabel()
        text.font = Constants.Fonts.recipeDescriptionTitle
        text.text = "Description"
        text.textColor = Constants.Colors.label
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let descriptionText: UILabel = {
        let text = UILabel()
        text.font = Constants.Fonts.regularText
        text.textColor = Constants.Colors.label
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let descriptionStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init(description: String = "Description should be here") {
        super.init(frame: .zero)
        setupView(description: description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(description: String) {
        addSubview(descriptionStack)
        descriptionText.text = description
        
        [descriptionLabel, descriptionText].forEach { descriptionStack.addArrangedSubview($0) }
        
    
        descriptionStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
