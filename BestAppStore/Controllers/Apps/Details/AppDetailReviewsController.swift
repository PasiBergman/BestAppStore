//
//  AppDetailReviewsController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppDetailReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var appReviews = [ReviewEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: appDetailReviewCellId)
        
        collectionView.contentInset = .init(top: 0, left: horizontalScollLeftRightPadding, bottom: 0, right: horizontalScollLeftRightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appReviews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailReviewCellId, for: indexPath) as! ReviewCell
        
        cell.appReview = appReviews[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - (horizontalScollLeftRightPadding * 2) , height: collectionView.frame.height)
    }
}
