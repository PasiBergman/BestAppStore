//
//  BaseCollectionViewController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    let activityIndicator = ActivityIndicatorView()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
}
