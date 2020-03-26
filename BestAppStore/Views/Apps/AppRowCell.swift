//
//  AppRowCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    var app: AppResult? = nil {
        didSet {
            appNameLabel.text = app?.name
            companyLabel.text = app?.artistName
            appIconImageView.setAppIcon(iconUrl: app?.artworkUrl100 ?? "")
        }
    }
    
    let appIconImageView = AppIconImageView(size: appIconWidthHeight, cornerRadius: appIconCornerRadius)
    let appNameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 18), numberOfLines: 2)
    let companyLabel: UILabel = {
        let label = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
        label.textColor = .lightGray
        return label
    }()
    let getButton = GetButton(text: "GET", backgroundColor: getButtonColor, textColor: getButtonTextColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            appNameLabel,
            companyLabel,
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            labelsStackView,
            getButton
        ])
        stackView.spacing = 16
        stackView.alignment = .center

        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fileprivate

}
