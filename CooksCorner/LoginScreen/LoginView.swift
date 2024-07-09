//
//  LoginView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit
import SnapKit

class LoginView: UIView {
    private lazy var headerContainer = UIView()
    private lazy var loginContainer = UIView()
    
    private let mainText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        
        let fullText = Constants.Texts.welcomeMessage
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [NSAttributedString.Key.font: Constants.Fonts.regular]
        )
        
        if let cooksCornerRange = fullText.range(of: "CooksCorner") {
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
    
    private let usernameField = CustomTextFieldView(
        titleText: "Username",
        placeholder: "Enter your username"
    )
    private let passwordField = CustomTextFieldView(
        titleText: "Password",
        placeholder: "Enter your password",
        isPasswordField: true
    )
    
    private let signInButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle(Constants.Texts.signInButton, for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.Colors.primary
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        
        let fullText = Constants.Texts.registerButton
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.gray]
        )
        
        if let range = fullText.range(of: "Sign Up Now") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(
                .foregroundColor,
                value: Constants.Colors.primary,
                range: nsRange
            )
        }
        
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        addSubview(headerContainer)
        addSubview(loginContainer)
        addSubview(registerButton)
        
        configureHeaderContainer()
        configureLoginContainer()
        
        headerContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        loginContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Padding.medium)
            make.top.equalTo(headerContainer.snp.bottom).offset(20)

        }
  
        registerButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.Padding.large)
            make.leading.trailing.equalToSuperview().inset(Constants.Padding.medium)
            make.height.equalTo(Constants.Size.textFieldHeight)
        }
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
    
    private func configureLoginContainer() {
        loginContainer.addSubview(usernameField)
        loginContainer.addSubview(passwordField)
        loginContainer.addSubview(signInButton)
        
        
        usernameField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(Constants.Padding.small)
            make.leading.trailing.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(Constants.Padding.large)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Size.textFieldHeight)
        }
    }
}

