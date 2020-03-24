//
//  ActivityIndicatorView.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 24.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
    convenience init() {
        self.init(style: .large)
        self.hidesWhenStopped = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
