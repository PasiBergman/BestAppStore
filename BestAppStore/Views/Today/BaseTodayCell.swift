//
//  BaseTodayCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 27.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem!
    
    override var isHighlighted: Bool {
        didSet {
            zoom(out: isHighlighted)
        }
    }
    
    fileprivate func zoom(out: Bool) {
        var transform: CGAffineTransform = .identity
        if out {
            transform = .init(scaleX: 0.9, y: 0.9)
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.transform = transform
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundView = UIView()
        let bgView = self.backgroundView!
        
        bgView.fillSuperview()
        bgView.layer.cornerRadius = todayCellCornerRadius
        bgView.backgroundColor = .white
        
        bgView.layer.shadowOpacity = 0.07
        bgView.layer.shadowRadius = 8
        bgView.layer.shadowOffset = .init(width: 0, height: 6)
        bgView.layer.shouldRasterize = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
