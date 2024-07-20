//
//  DifficultyLevelView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//
enum DifficultyLevel {
    case easy
    case medium
    case hard
    
    var text: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
}

import UIKit

class DifficultyLevelView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Constants.Colors.label
        label.font = Constants.Fonts.smallText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(level: String = "Easy") {
        super.init(frame: .zero)
        setupView(level: level)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(level: String) {
        setupView(level: level)
    }
    
    private func setupView(level: String) {
        backgroundColor = Constants.Colors.secondary
        layer.cornerRadius = 15
        clipsToBounds = true
        
        label.text = level
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
