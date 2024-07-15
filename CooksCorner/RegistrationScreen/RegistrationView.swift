//
//  RegistrationView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 10/07/2024.
//

import UIKit
import SnapKit

class RegistrationView: UIView {
    private lazy var alertView = AlertView()
    private lazy var headerContainer = UIView()
    private lazy var registerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let mainText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        
        let fullText = "Sign up for delicious Discoveries!"
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [NSAttributedString.Key.font: Constants.Fonts.regular]
        )
        
        if let cooksCornerRange = fullText.range(of: "Discoveries") {
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
        titleText: "Name",
        placeholder: "Enter your name",
        icon: "person"
    )
    
    private let mailField = CustomTextFieldView(
        titleText: "Gmail",
        placeholder: "Enter your Gmail",
        icon: "at"
    )
    
    private let passwordField = CustomTextFieldView(
        titleText: "Password",
        placeholder: "Enter your password",
        isPasswordField: true,
        icon: ""
    )
    
    private let rePasswordField = CustomTextFieldView(
        titleText: "Re-Password",
        placeholder: "Re-Enter your password",
        isPasswordField: true,
        icon: ""
    )
    
    let signUpButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.Colors.primary
        button.layer.cornerRadius = CGFloat(Constants.Size.cornerRadius)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        
        let fullText = "Already have an account? Sign In now"
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.gray]
        )
        
        if let range = fullText.range(of: "Sign In now") {
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
        addSubview(registerStackView)
        addSubview(registerButton)
        addSubview(alertView)
        
        configureAlert()
        configureHeaderContainer()
        configureRegisterContainer()
        
        headerContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        registerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Padding.medium)
            make.top.equalTo(headerContainer.snp.bottom).offset(20)
            make.height.equalToSuperview().dividedBy(2.3)

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
    
    private func configureRegisterContainer() {
        [
            usernameField,
            mailField,
            passwordField,
            rePasswordField,
            signUpButton
            
        ].forEach {registerStackView.addArrangedSubview($0)}
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Size.textFieldHeight)
        }
    }
}

extension RegistrationView {
    func getUsername() -> String? {
        return usernameField.textField.text
    }
    
    func getMail() -> String? {
        return mailField.textField.text
    }
    
    func getPassword() -> String? {
        return passwordField.textField.text
    }
    
    func getRePassword() -> String? {
        return rePasswordField.textField.text
    }
}

extension RegistrationView {
    private func configureAlert() {
        alertView.isHidden = true
        
        alertView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Padding.small)
            make.height.equalTo(Constants.Size.textFieldHeight)
            make.top.equalTo(safeAreaLayoutGuide).inset(-170)
        }
    }
    
    func showAlert(message: String) {
        alertView.isHidden = false
        alertView.setMessage(message)
        
        layoutIfNeeded()
        
        alertView.snp.updateConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(5)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.alertView.snp.updateConstraints { make in
                    make.top.equalTo(self.safeAreaLayoutGuide).inset(-170)
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                })
            }
        }
    }
}
