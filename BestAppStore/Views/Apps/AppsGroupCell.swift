//
//  AppsGroupCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    var feed: Feed? = nil {
        didSet {
            appGroupTitleLabel.text = feed?.title
            horizontalController.apps = feed?.results ?? []
        }
    }
    
    let appGroupTitleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 22))
    
    let horizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(appGroupTitleLabel)
        appGroupTitleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: horizontalScollLeftRightPadding, left: horizontalScollLeftRightPadding, bottom: 0, right: horizontalScollLeftRightPadding))
        
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: appGroupTitleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
    }
    
    
    
    // MARK: - Required
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
