//
//  TodayController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let todayItems = [
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligentry organize your life the right way.", backgroundColor: .white),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything.", backgroundColor: #colorLiteral(red: 0.9746602178, green: 0.9583788514, blue: 0.7279261351, alpha: 1)),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = todayBackgroundColor
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var selectedCellFrame: CGRect!
    var fullScreenController: AppFullScreenController!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the cell which was selected
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        // Get absolute coordinates (frame) of the selected cell
        guard let startingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
            return
        }
        selectedCellFrame = startingFrame
        
        // AppFullScreenController
        let appFullScreenController = AppFullScreenController()
        self.fullScreenController = appFullScreenController
        appFullScreenController.todayItem = todayItems[indexPath.row]
        appFullScreenController.handleCloseViewClick = handleRemoveFullScreenViewClick
        let appFullScreenView = appFullScreenController.view!
        view.addSubview(appFullScreenView)
        addChild(appFullScreenController)
        
        collectionView.isUserInteractionEnabled = false
        
        appFullScreenView.translatesAutoresizingMaskIntoConstraints = false
        
        appFullScreenView.layer.cornerRadius = todayCellCornerRadius
        
        topConstraint = appFullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = appFullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = appFullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.size.width)
        heightConstraint = appFullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.size.height)
        
        NSLayoutConstraint.activate([
            topConstraint!,
            leadingConstraint!,
            widthConstraint!,
            heightConstraint!,
        ])
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height

            self.view.layoutIfNeeded()
            
            self.fullScreenController.view.layer.cornerRadius = 0
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
            
            guard let headerCell = self.fullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
            headerCell.todayCell.topConstraint?.constant = 48
            headerCell.todayCell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    
    @objc func handleRemoveFullScreenViewClick() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.fullScreenController.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            
            self.topConstraint?.constant = self.selectedCellFrame.origin.y
            self.leadingConstraint?.constant = self.selectedCellFrame.origin.x
            self.widthConstraint?.constant = self.selectedCellFrame.size.width
            self.heightConstraint?.constant = self.selectedCellFrame.size.height
            
            let fullHeight = self.view.frame.size.height
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = fullHeight - tabBarFrame.height
            }
            
            self.view.layoutIfNeeded()
            
            guard let headerCell = self.fullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
            headerCell.todayCell.topConstraint?.constant = 24
            headerCell.todayCell.layoutIfNeeded()
            
        }) { (_) in
            self.fullScreenController.view.removeFromSuperview()
            self.fullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
        
        cell.todayItem = todayItems[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: collectionView.frame.width - (2 * horizontalScollLeftRightPadding), height: todayCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: horizontalScollLeftRightPadding * 2, left: 0, bottom: horizontalScollLeftRightPadding * 2, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
}
