//
//  AlertView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 10/07/2024.
//

import UIKit
import SnapKit

class AlertView: UIView {
    
    private let messageLabel: UILabel = {
        let message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.textColor = .red
        message.textAlignment = .center
        message.font = Constants.Fonts.smallText
        return message
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = CGFloat(Constants.Size.cornerRadius)
        layer.masksToBounds = true
        
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
}
