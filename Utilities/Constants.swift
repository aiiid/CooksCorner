//
//  Constants.swift
//  CooksCorner
//
//  Created by Ai Hawok on 08/07/2024.
//

import UIKit

class Constants {
    struct Colors {
        static let backgroundColor = UIColor.systemBackground
        static let primary = UIColor(hex: "#FA9E31")
        static let secondary = UIColor(hex: "#FFF6DE")
        
        static let gray: UIColor = .systemGray3
        
        static let label = UIColor(hex: "#343434")
        static let textFaded = UIColor(hex: "#666666")
       
        
    }
    
    struct Padding {
        static let small: CGFloat = 16
        static let medium: CGFloat = 20
        static let large: CGFloat = 25
    }
    
    struct Size {
        static let textFieldHeight: CGFloat = 45
        static let mainTextWidth = 250
        static let cornerRadius = 23
        static let recipeCellWidth = 169
        static let recipeCellHeight = 209
    }
    
    struct Fonts {
        static let regular = UIFont(name: "Poppins-Regular", size: 24)!
        static let light = UIFont(name: "Poppins-Light", size: 24)!
        static let bold = UIFont(name: "Poppins-Bold", size: 24)!
        static let semibold = UIFont(name: "Poppins-Semibold", size: 24)!
        
        static let smallText = UIFont(name: "Poppins-Regular", size: 14)!
        
        static let recipeCellTitle = UIFont(name: "Poppins-SemiBold", size: 16)!
        static let recipeCellAuthor = UIFont(name: "Poppins-Regular", size: 15)!
        
        static let regularText = UIFont(name: "Poppins-Regular", size: 14)!
        static let boldText = UIFont(name: "Poppins-Bold", size: 16)!
        static let semiboldText = UIFont(name: "Poppins-SemiBold", size: 16)!
        
        static let semiboldTitle = UIFont(name: "Poppins-SemiBold", size: 20)!
        static let recipeDescriptionTitle  = UIFont(name: "Poppins-SemiBold", size: 16)!
         
    }
    
    struct Texts {
        static let welcomeMessage = "Welcome Back\nTo CooksCorner !"
        static let signInButton = "Sign In"
        static let registerButton = "I don’t have an account? Sign Up Now"
        static let registrationMessage = "Sign up for delicious Discoveries!"
    }
}
