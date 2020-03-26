//
//  AppDetailPreviewController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppDetailPreviewController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    var screenshotUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: appDetailScreenshotCellId)
        
        collectionView.contentInset = .init(top: 0, left: horizontalScollLeftRightPadding, bottom: 0, right: horizontalScollLeftRightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appDetailScreenshotCellId, for: indexPath) as! ScreenshotCell
        
        cell.screenshotUrl = screenshotUrls[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: appDetailScreenshotWidth, height: collectionView.frame.height)
    }
}
