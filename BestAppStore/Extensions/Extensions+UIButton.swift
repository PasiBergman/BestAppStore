//
//  Extensions+UIButton.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}
