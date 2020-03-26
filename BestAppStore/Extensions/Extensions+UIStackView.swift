//
//  Extensions+UIStackView.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

extension UIStackView {
    @objc convenience init(arrangedSubviews: [UIView], spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
    }
}
