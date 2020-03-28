//
//  TodayController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var todayItems = [TodayItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = todayBackgroundColor
        
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayAppsCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        fetchData()
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
        
        let todayItem = todayItems[indexPath.item]
        
        
        if todayItem.cellType == .multiple {
            let fullScreenController = TodayAppsController(mode: .fullscreen)
            fullScreenController.apps = todayItem.apps
            present(BackEnabledNavigationController(rootViewController: fullScreenController), animated: true)
            return
        }

        
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
        
        let cellId = todayItems[indexPath.row].cellType.rawValue
        let todayItem = todayItems[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
    
        cell.todayItem = todayItem
        
        (cell as? TodayAppsCell)?.todayAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTodayAppsTap)))
        
        return cell
    }
    
    @objc func handleTodayAppsTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayAppsCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else {
                    return
                }
                let todayItem = todayItems[indexPath.item]
                let appsFullScreenController = TodayAppsController(mode: .fullscreen)
                appsFullScreenController.apps = todayItem.apps
                present(BackEnabledNavigationController(rootViewController: appsFullScreenController), animated: true)
                return
            }
            superView = superView?.superview
        }
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
    
    // MARK: - Fileprivate
    
    fileprivate func fetchData() {
        
        var dailyApps: Feed?
        var dailyGames: Feed?
        
        let dispatchGroup = DispatchGroup()
        
        activityIndicator.startAnimating()
        
        dispatchGroup.enter()
        ApiService.shared.editorsChoiceApps(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch editor's choice game results:", err)
            } else {
                if let feed = feedResult?.feed {
                    dailyApps = feed
                }
            }
            dispatchGroup.leave()
        })

        dispatchGroup.enter()
        ApiService.shared.editorsChoiceGames(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch editor's choice game results:", err)
            } else {
                if let feed = feedResult?.feed {
                    dailyGames = feed
                }
            }
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: .main) {
            
            self.todayItems = [
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligentry organize your life the right way.", backgroundColor: .white, apps: nil, cellType: .single),
                TodayItem.init(category: "THE DAILY LIST", title: dailyApps?.title ?? "", image: nil, description: "", backgroundColor: .white, apps: dailyApps?.results, cellType: .multiple),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything.", backgroundColor: #colorLiteral(red: 0.9746602178, green: 0.9583788514, blue: 0.7279261351, alpha: 1), apps: nil, cellType: .single),
                TodayItem.init(category: "THE DAILY LIST", title: dailyGames?.title ?? "", image: nil, description: "", backgroundColor: .white, apps: dailyGames?.results, cellType: .multiple),
            ]
            
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }

}
