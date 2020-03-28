//
//  TodayAppsController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 27.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayAppsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var feed: Feed?
    
    let multipleAppsCellId = "multipleAppsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: multipleAppsCellId)
        
        fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, feed?.results.count ?? 0)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppsCellId, for: indexPath) as! MultipleAppsCell
        
        cell.app = feed?.results[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellHeight = (collectionView.frame.height - 3 * lineSpacing) / 4
        
        return .init(width: collectionView.frame.width, height: cellHeight)
    }
    
    let lineSpacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        activityIndicator.startAnimating()
        
        dispatchGroup.enter()
        ApiService.shared.editorsChoiceGames(completion: { (feedResult, err) in
            if let err = err {
                print("Failed to fetch editor's choice game results:", err)
            } else {
                if let feed = feedResult?.feed {
                    self.feed = feed
                }
            }
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }

    
}
