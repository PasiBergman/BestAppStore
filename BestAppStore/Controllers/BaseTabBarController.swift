//
//  BaseTabBarController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 22.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        // Today
        let todayNavController = createNavController(UIViewController(), title: todayBarTitle, iconName: todayTabBarIconName)
        
        // Apps
        let appsNavController = createNavController(UIViewController(), title: appsBarTitle, iconName: appsTabBarIconName)
        
        // Search
        let searchNavController = createNavController(SearchController(), title: searchBarTitle, iconName: searchTabBarIconName)
        
        viewControllers = [
            appsNavController,
            todayNavController,
            searchNavController,
        ]
    }
    
    // MARK: - Fileprivate
    
    fileprivate func createNavController(_ viewController: UIViewController, title: String, iconName: String) -> UINavigationController {
        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: iconName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
}
