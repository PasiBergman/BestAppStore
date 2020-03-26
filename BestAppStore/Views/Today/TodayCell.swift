//
//  TodayCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    let todayImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "garden"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 250).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.cornerRadius = todayCellCornerRadius
        backgroundColor = .white
        
        addSubview(todayImageView)
        todayImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        todayImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
