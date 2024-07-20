//
//  TimeView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 18/07/2024.
//

import UIKit

class CookingTimeView: UIView {
    
    var timeText: UILabel = {
        let text = UILabel()
        text.font = Constants.Fonts.smallText
        text.numberOfLines = 0
        text.textColor = Constants.Colors.primary
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let timeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "timer")
        image.tintColor = Constants.Colors.primary
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let timeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    init(minutes: Int = 0) {
        super.init(frame: .zero)
        setupView(minutes: minutes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(minutes: Int) {
        timeText.text = "\(minutes) MINUTES"
        
        addSubview(timeStack)
        [timeIcon, timeText].forEach { timeStack.addArrangedSubview($0) }
        
        timeIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }

        timeStack.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
}
