//
//  LoginView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit
import SnapKit

class LoginView: BaseAuthView {
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
    
    let emailField = CustomTextFieldView(
        titleText: "Email",
        placeholder: "Enter your username",
        icon: "at"
    )
    let passwordField = CustomTextFieldView(
        titleText: "Password",
        placeholder: "Enter your password",
        isPasswordField: true,
        icon: ""
    )
    
    let signInButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.Colors.primary
        button.layer.cornerRadius = CGFloat(Constants.Size.cornerRadius)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        
        let fullText = "Don't have an account? Sign Up now"
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.gray]
        )
        
        if let range = fullText.range(of: "Sign Up now") {
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
        
        bringSubviewToFront(alertView)
        
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
            make.height.equalToSuperview().dividedBy(3)
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
        loginContainer.addSubview(emailField)
        loginContainer.addSubview(passwordField)
        loginContainer.addSubview(signInButton)
        
        emailField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(Constants.Padding.small)
            make.leading.trailing.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(Constants.Padding.large)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Size.textFieldHeight)
        }
    }
}
