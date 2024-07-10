//
//  CustomTextField.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {
    
    private let eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.tintColor = Constants.Colors.gray
        return button
    }()
    
    init(placeholder: String, isPasswordField: Bool = false, icon: String?) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isPasswordField
        self.textContentType = isPasswordField ? .oneTimeCode : .none

        configureTextField(isPasswordField: isPasswordField, icon: icon)
        disableSmartFeatures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField(isPasswordField: Bool, icon: String?) {
        configurePlaceholder()
        styleTextField()
        addPadding()
        
        if isPasswordField {
            configurePasswordField()
        } else {
            if let icon = icon {
                configureIcon(with: icon)
            }
        }
    }
    
    private func configurePlaceholder() {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: Constants.Fonts.small
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: placeholderAttributes)
    }
    
    private func styleTextField() {
        borderStyle = .none
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 23
        layer.masksToBounds = true
    }
    
    private func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        leftView = paddingView
        leftViewMode = .always
    }
    
    private func configureIcon(with icon: String) {
        let rightIcon = UIImageView(image: UIImage(systemName: icon))
        rightIcon.tintColor = Constants.Colors.gray
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        
        containerView.addSubview(rightPaddingView)
        containerView.addSubview(rightIcon)
        setupConstraints(for: rightPaddingView, and: rightIcon, in: containerView)
        
        rightView = containerView
        rightViewMode = .always
    }
    
    private func configurePasswordField() {
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        
        containerView.addSubview(rightPaddingView)
        containerView.addSubview(eyeButton)
        
        setupConstraints(for: rightPaddingView, and: eyeButton, in: containerView)
        
        rightView = containerView
        rightViewMode = .always
    }
    
    
    
    private func setupConstraints(
        for rightPaddingView: UIView,
        and eyeButton: UIView,
        in containerView: UIView
    ) {
        rightPaddingView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalToSuperview()
        }
        
        eyeButton.snp.makeConstraints { make in
            make.leading.equalTo(rightPaddingView.snp.trailing)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func disableSmartFeatures() {
        autocorrectionType = .no
        spellCheckingType = .no
        smartQuotesType = .no
        smartDashesType = .no
        smartInsertDeleteType = .no
        autocapitalizationType = .none
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}
