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

        view.backgroundColor = .white
        
        // Today
        let todayNavController = createNavController(TodayController(), title: todayBarTitle, iconName: todayTabBarIconName)
        
        // Apps
        let appsNavController = createNavController(AppsController(), title: appsBarTitle, iconName: appsTabBarIconName)
        
        // Search
        let searchNavController = createNavController(SearchController(), title: searchBarTitle, iconName: searchTabBarIconName)
        
        viewControllers = [
            todayNavController,
            appsNavController,
            searchNavController,
        ]
    }
    
    // MARK: - Fileprivate
    
    fileprivate func createNavController(_ viewController: UIViewController, title: String, iconName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: iconName)
        navController.navigationBar.prefersLargeTitles = true

        return navController
    }
}
