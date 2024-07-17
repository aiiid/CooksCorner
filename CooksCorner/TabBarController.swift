//
//  TabBarController.swift
//  CooksCorner
//
//  Created by Ai Hawok on 12/07/2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let tabBar = self.tabBar as? UITabBar {
            addShadowToTabBar(tabBar: tabBar)
        }
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let profileVC = ProfileViewController()
        
        let homeNavController = UINavigationController(rootViewController: homeVC)
        let searchNavController = UINavigationController(rootViewController: searchVC)
        let profileNavController = UINavigationController(rootViewController: profileVC)
        
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
        
        viewControllers = [homeNavController, searchNavController, profileNavController]
    }
    
    private func setupUI() {
        let primaryColor = Constants.Colors.primary
        let gray = Constants.Colors.gray
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
        
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: primaryColor], for: .selected)
        
        UITabBar.appearance().tintColor = primaryColor
        UITabBar.appearance().unselectedItemTintColor = gray
    }
    
    private func addShadowToTabBar(tabBar: UITabBar) {
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 10
        tabBar.layer.masksToBounds = false
    }
}
