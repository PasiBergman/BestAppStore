//
//  AppIconImageView.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppIconImageView: UIImageView {
    init(size: CGFloat, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.widthAnchor.constraint(equalToConstant: size).isActive = true
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = .clear
    }
    
    func setAppIcon(iconUrl: String) {
        guard let url = URL(string: iconUrl) else { return }
        self.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
