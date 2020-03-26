//
//  ScreenshotCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    var screenshotUrl: String? {
        didSet {
            screenshotImageView.setScreenshot(screenshotUrl: screenshotUrl ?? "")
        }
    }
    
    let screenshotImageView = ScreenshotImageView(cornerRadius: appDetailScreenshotCornerRadius)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // backgroundColor = .clear
        
        addSubview(screenshotImageView)
        screenshotImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
