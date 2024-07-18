//
//  SplashScreenView.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit
import SnapKit

class SplashView: UIView {
    
    let mainImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "CooksCornerSkilletCooktop"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let mainText: UILabel = {
        var text = UILabel()
        text.text = "Cooks corner"
        text.font = Constants.Fonts.regular
        text.textColor = .white
        text.textAlignment = .center
        return text
    }()
    
    let versionLabel: UILabel = {
        var text = UILabel()
        text.font = Constants.Fonts.smallText
        text.textColor = .white
        text.textAlignment = .center
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        backgroundColor = Constants.Colors.primary
        addSubview(mainImage)
        addSubview(mainText)
        addSubview(versionLabel)
        
        mainImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(90)
        }
        
        mainText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version \(version)"
        }
        versionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.Padding.large)
            make.centerX.equalToSuperview()
        }
        
        
    }
}
