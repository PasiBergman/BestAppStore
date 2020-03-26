//
//  ReviewRowCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppDetailReviewRowCell: UICollectionViewCell {
    
    let appDetailReviewsController = AppDetailReviewsController()
    
    let reviewsLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 22))
    
    let spacerView = SpacerView(space: 32)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewsLabel)
        reviewsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: horizontalScollLeftRightPadding, bottom: 0, right: horizontalScollLeftRightPadding))
        
        addSubview(spacerView)
        spacerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        addSubview(appDetailReviewsController.view)
        appDetailReviewsController.view.anchor(top: reviewsLabel.bottomAnchor, leading: leadingAnchor, bottom: spacerView.topAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
