//
//  AppsController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppsPageController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var activityIndicator = ActivityIndicatorView()
    var groups = [Feed]()
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        
        collectionView!.register(AppsGroupCell.self, forCellWithReuseIdentifier: appsCollectionViewCellId)
        collectionView!.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: appsPageHeaderViewCellId)
        
        setupActivityIndicator()
        
        fetchData()

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appsCollectionViewCellId, for: indexPath) as! AppsGroupCell
        
        cell.feed = groups[indexPath.item]
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: appsPageHeaderViewCellId, for: indexPath) as! AppsPageHeader
        
        header.socialApps = socialApps
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
    }
    
    fileprivate func fetchData() {
        
        var appGroupEditorsChoice: Feed?
        var appGroupTopFree: Feed?
        var appGroupTopPaid: Feed?
        var appGroupTopGrossing: Feed?
        
        let dispatchGroup = DispatchGroup()
        
        activityIndicator.startAnimating()
        
        dispatchGroup.enter()
        ApiService.shared.fetchSocialApps(completion: { (result, err) in
            if let err = err {
                print("Failed to fetch social apps result:", err)
            } else {
                if let data = result {
                    self.socialApps = data
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ApiService.shared.editorsChoiceApps(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch editor's choice app results:", err)
            } else {
                if let appGroup = feedResult?.feed {
                    appGroupEditorsChoice = appGroup
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ApiService.shared.topFreeApps(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch top free apps results:", err)
            } else {
                if let appGroup = feedResult?.feed {
                    appGroupTopFree = appGroup
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ApiService.shared.topPaidApps(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch top paid apps results:", err)
            } else {
                if let appGroup = feedResult?.feed {
                    appGroupTopPaid = appGroup
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ApiService.shared.topGrossingApps(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch top grossing apps results:", err)
            } else {
                if let appGroup = feedResult?.feed {
                    appGroupTopGrossing = appGroup
                }
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            if let appGroup = appGroupEditorsChoice {
                self.groups.append(appGroup)
            }
            if let appGroup = appGroupTopFree {
                self.groups.append(appGroup)
            }
            if let appGroup = appGroupTopPaid {
                self.groups.append(appGroup)
            }
            if let appGroup = appGroupTopGrossing {
                self.groups.append(appGroup)
            }
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}
