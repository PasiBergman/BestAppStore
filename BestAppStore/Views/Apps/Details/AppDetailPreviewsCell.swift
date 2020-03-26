//
//  AppDetailPreviewCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppDetailPreviewCell: UICollectionViewCell {
    
    let appDetailPreviewController = AppDetailPreviewController()
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 22))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewLabel)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: horizontalScollLeftRightPadding, bottom: 0, right: horizontalScollLeftRightPadding))
        
        addSubview(appDetailPreviewController.view)
        appDetailPreviewController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
