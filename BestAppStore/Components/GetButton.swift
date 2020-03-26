//
//  GetButton.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class GetButton: UIButton {
    init(text: String, backgroundColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.setTitleColor(textColor, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitle(text, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = 16
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
