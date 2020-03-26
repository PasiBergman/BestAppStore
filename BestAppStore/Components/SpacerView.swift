//
//  SpacerView.swift
//  SlideOutMenu
//
//  Created by Pasi Bergman on 19.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class SpacerView: UIView {
    
    let space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: space, height: space)
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
