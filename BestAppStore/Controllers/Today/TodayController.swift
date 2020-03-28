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

    var anchoredConstraints: AnchoredConstraints?
    var selectedCellFrame: CGRect?
    var fullScreenController: AppFullScreenController!
    
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
        
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch todayItems[indexPath.item].cellType {
        case .multiple:
            showTodayAppsInFullSceenMode(indexPath)
        default:
            showSingleAppInFullSceenMode(indexPath)
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
    
    fileprivate func showTodayAppsInFullSceenMode(_ indexPath: IndexPath) {
        let fullScreenController = TodayAppsController(mode: .fullscreen)
        fullScreenController.apps = todayItems[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullScreenController), animated: true)
    }
    
    fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
        let appFullScreenController = AppFullScreenController()
        self.fullScreenController = appFullScreenController
        appFullScreenController.todayItem = todayItems[indexPath.row]
        appFullScreenController.handleCloseViewClick = {
            self.handleRemoveFullScreenViewClick()
        }
        let appFullScreenView = appFullScreenController.view!
        view.addSubview(appFullScreenView)
        addChild(appFullScreenController)
        
        appFullScreenView.layer.cornerRadius = todayCellCornerRadius
    }
    
    fileprivate func setupSelectedCellFrame(_ indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        // Get absolute coordinates (frame) of the selected cell
        guard let startingFrame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {
            return
        }
        selectedCellFrame = startingFrame
    }

    fileprivate func setupSingleAppSullScreenInStartingPosition(_ indexPath: IndexPath) {

        setupSelectedCellFrame(indexPath)

        collectionView.isUserInteractionEnabled = false
        
        let appFullScreenView = fullScreenController.view!
        appFullScreenView.translatesAutoresizingMaskIntoConstraints = false

        guard let selectedCellFrame = self.selectedCellFrame else {
            return
        }
        
        anchoredConstraints = appFullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: selectedCellFrame.origin.y, left: selectedCellFrame.origin.x, bottom: 0, right: 0), size: .init(width: selectedCellFrame.size.width, height: selectedCellFrame.size.height))
        
        self.view.layoutIfNeeded()
    }

    fileprivate func animateSingleAppFullScreenToFinalPosition() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.fullScreenController.view.layer.cornerRadius = 0
            
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
            
            
            guard let headerCell = self.fullScreenController.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else { return }
            headerCell.todayCell.topConstraint?.constant = 48
            headerCell.todayCell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppInFullSceenMode(_ indexPath: IndexPath) {
        // Get the cell which was selected
        
        setupSingleAppFullScreenController(indexPath)
        
        setupSingleAppSullScreenInStartingPosition(indexPath)
        
        animateSingleAppFullScreenToFinalPosition()
    }
    
    
    @objc fileprivate func handleRemoveFullScreenViewClick() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.fullScreenController.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            
            guard let selectedCellFrame = self.selectedCellFrame else { return }
            self.anchoredConstraints?.top?.constant = selectedCellFrame.origin.y
            self.anchoredConstraints?.leading?.constant = selectedCellFrame.origin.x
            self.anchoredConstraints?.width?.constant = selectedCellFrame.size.width
            self.anchoredConstraints?.height?.constant = selectedCellFrame.size.height
            
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
