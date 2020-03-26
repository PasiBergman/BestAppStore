//
//  AppDetailController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppDetailController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let appId: String
    fileprivate let appTitle: String
    var appData = [SoftwareResult]()
    var appReviews = [ReviewEntry]()
    
    let cellsPerApp: Int = 3
    
    init(appId: String, appTitle: String) {
        self.appId = appId
        self.appTitle = appTitle
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailInfoCell.self, forCellWithReuseIdentifier: appDetailCellId)
        collectionView.register(AppDetailPreviewCell.self, forCellWithReuseIdentifier: appDetailPreviewCellId)
        
        collectionView.register(AppDetailReviewRowCell.self, forCellWithReuseIdentifier: appDetailReviewRowCellId)
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.title = appTitle
        
        fetchAppDetails(appId: appId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appData.count * cellsPerApp
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailCellId, for: indexPath) as! AppDetailInfoCell
            cell.appData = appData[indexPath.item]
        
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailPreviewCellId, for: indexPath) as! AppDetailPreviewCell
            
            cell.appDetailPreviewController.screenshotUrls = appData[indexPath.item - 1].screenshotUrls
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailReviewRowCellId, for: indexPath) as! AppDetailReviewRowCell
            
            cell.appDetailReviewsController.appReviews = appReviews
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            // Calculate the necessary size of our app detail cell
            let dummyCell = AppDetailInfoCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.appData = appData[indexPath.item]
            dummyCell.layoutIfNeeded()
            
            // Get the estimated size from the dummy cell
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 500)
        } else {
            return .init(width: view.frame.width, height: 300)
        }
    }
    
    fileprivate func fetchAppDetails(appId: String) {
        activityIndicator.startAnimating()
    
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        ApiService.shared.fetchAppDetails(appId: appId, completion: {
            (data, err) in
            if let err = err {
                print("Failed to fetch search results:", err)
            } else {
                if let res = data?.results {
                    self.appData = res
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ApiService.shared.fetchAppRevies(appId: appId, completion: {
            (data, err) in
            if let err = err {
                print("Failed to fetch app reviews:", err)
            } else {
                if let res = data?.feed.entry {
                    self.appReviews = res
                } else {
                    self.appReviews = [ReviewEntry]()
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
