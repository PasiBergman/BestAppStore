//
//  ScreenShotImageView.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class ScreenshotImageView: UIImageView {
    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = .clear
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(white: 0.5, alpha: 1).cgColor
        self.contentMode = .scaleAspectFill
    }
    
    func setScreenshot(screenshotUrl: String) {
        guard let url = URL(string: screenshotUrl) else {
            layer.borderWidth = 0
            return
        }
        self.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
