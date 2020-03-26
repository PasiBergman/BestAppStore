//
//  TodayCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.cornerRadius = todayCellCornerRadius
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
