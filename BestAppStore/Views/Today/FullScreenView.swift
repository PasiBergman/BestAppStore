//
//  FullScreenView.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class FullScreenView: UIView {
    
    fileprivate let initialFrame: CGRect
    
    override init(frame: CGRect) {
        initialFrame = frame

        super.init(frame: frame)
        backgroundColor = .red
        
        layer.cornerRadius = todayCellCornerRadius
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleFullViewTap)))
        
    }
    
    @objc func handleFullViewTap(gesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.frame = self.initialFrame
            self.layer.cornerRadius = todayCellCornerRadius
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
