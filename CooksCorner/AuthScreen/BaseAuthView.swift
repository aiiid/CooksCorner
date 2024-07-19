//
//  BaseAuthView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 19/07/2024.
//

import UIKit
import SnapKit

class BaseAuthView: UIView {
    var alertView = AlertView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAlertView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAlertView()
    }
    
    private func setupAlertView() {
        alertView.isHidden = true
        alertView.alpha = 0
        addSubview(alertView)
        
        alertView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.Padding.small)
            make.height.equalTo(Constants.Size.textFieldHeight)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(-100)
        }
    }
    
    func showAlert(message: String, color: CGColor = UIColor.red.cgColor) {
        alertView.isHidden = false
        alertView.set(message: message, color: color)
        
        layoutIfNeeded()
        
        alertView.snp.updateConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(5)
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alertView.alpha = 1
            self.layoutIfNeeded()
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.alertView.snp.updateConstraints { make in
                    make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(-100)
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.alertView.alpha = 0
                    self.layoutIfNeeded()
                }) { _ in
                    self.alertView.isHidden = true
                }
            }
        }
    }
}
