//
//  CustomTextFieldView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 09/07/2024.
//

import UIKit

class CustomTextFieldView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.small
        label.textColor = Constants.Colors.primary
        return label
    }()
    
    let textField: CustomTextField
    
    init(titleText: String, placeholder: String, isPasswordField: Bool = false) {
        self.textField = CustomTextField(placeholder: placeholder, isPasswordField: isPasswordField)
        super.init(frame: .zero)
        
        titleLabel.text = titleText
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constants.Size.textFieldHeight)
        }
    }
}
