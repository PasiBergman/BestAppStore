//
//  AppFullScreenController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    internal let initialFrame: CGRect
    internal let fullScreenFrame: CGRect
    internal let todayTabBarController: UITabBarController?
    
    init(frame: CGRect, endFrame: CGRect, tabBarController: UITabBarController?) {
        self.initialFrame = frame
        self.todayTabBarController = tabBarController
        self.fullScreenFrame = endFrame
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        
        tableView.layer.cornerRadius = todayCellCornerRadius
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFullViewTap)))
        
    }
    
    @objc func handleFullViewTap(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.view.frame = self.initialFrame
            self.view.layer.cornerRadius = todayCellCornerRadius
            let fullHeight = self.fullScreenFrame.size.height
            if let tabBarFrame = self.todayTabBarController?.tabBar.frame {
                self.todayTabBarController?.tabBar.frame.origin.y = fullHeight - tabBarFrame.height
            }
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
            self.removeFromParent()
        })
    }
}
