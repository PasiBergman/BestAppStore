//
//  AppsPageHeader.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 24.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let appsHeaderHorizontalController = AppsHeaderHorizontalController()
    var socialApps = [SocialApp]() {
        didSet {
            appsHeaderHorizontalController.socialApps = socialApps
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appsHeaderHorizontalController.view)
        appsHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
