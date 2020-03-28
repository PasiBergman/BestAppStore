//
//  CloseButton.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 28.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class CloseButton: UIButton {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        tintColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
