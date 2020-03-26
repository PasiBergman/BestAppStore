//
//  TodayController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = todayBackgroundColor
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the cell which was selected
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        // Get absolute coordinates (frame) of the selected cell
        guard let startingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
            return
        }
        let fullScreenController = AppFullScreenController(frame: startingFrame, endFrame: view.frame, tabBarController: tabBarController)
        view.addSubview(fullScreenController.view)
        addChild(fullScreenController)
        fullScreenController.view.frame = startingFrame
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            fullScreenController.view.frame = self.view.frame
            fullScreenController.view.layer.cornerRadius = 0
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
        }, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.width - (2 * horizontalScollLeftRightPadding), height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: horizontalScollLeftRightPadding * 2, left: 0, bottom: horizontalScollLeftRightPadding * 2, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
}
