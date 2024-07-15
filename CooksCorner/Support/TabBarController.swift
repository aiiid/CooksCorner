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
}
