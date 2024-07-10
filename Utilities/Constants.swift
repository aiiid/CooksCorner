//
//  Constants.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit

class Constants {
    struct Colors {
        static let primary = UIColor(hex: "#FA9E31")
        static let backgroundColor = UIColor.systemBackground
        static let green = UIColor(hex: "#1BA228")
        static let gray: UIColor = .systemGray3
        static let textColor = UIColor.label
    }
    
    struct Padding {
        static let small: CGFloat = 16
        static let medium: CGFloat = 20
        static let large: CGFloat = 25
    }
    
    struct Size {
        static let textFieldHeight: CGFloat = 45
        static let mainTextWidth = 250
    }
    
    struct Fonts {
        static let regular = UIFont(name: "Poppins-Regular", size: 24)!
        static let light = UIFont(name: "Poppins-Light", size: 24)!
        static let bold = UIFont(name: "Poppins-Bold", size: 24)!
        static let small = UIFont(name: "Poppins-Regular", size: 14)!
    }
    
    struct Texts {
        static let welcomeMessage = "Welcome Back\nTo CooksCorner !"
        static let signInButton = "Sign In"
        static let registerButton = "I don’t have an account? Sign Up Now"
        static let registrationMessage = "Sign up for delicious Discoveries!"
    }
}
