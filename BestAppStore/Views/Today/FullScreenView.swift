//
//  FullScreenView.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class FullScreenView: UIView {
    
    fileprivate var initialFrame: CGRect?
    fileprivate var tabBarCtr: UITabBarController?
    fileprivate var viewFullFrame: CGRect?
    
    convenience init(frame: CGRect, endFrame: CGRect, tabBarController: UITabBarController?) {
        self.init(frame: frame)
        initialFrame = frame
        tabBarCtr = tabBarController
        viewFullFrame = endFrame
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        layer.cornerRadius = todayCellCornerRadius
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFullViewTap)))
        
    }
    
    @objc func handleFullViewTap(gesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.frame = self.initialFrame!
            self.layer.cornerRadius = todayCellCornerRadius
            if let tabBarFrame = self.tabBarCtr?.tabBar.frame,
               let fullHeight = self.viewFullFrame?.size.height {
                self.tabBarCtr?.tabBar.frame.origin.y = fullHeight - tabBarFrame.height
            }
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
