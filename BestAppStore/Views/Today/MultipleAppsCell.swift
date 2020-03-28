//
//  MultipleAppsCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 27.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class MultipleAppsCell: UICollectionViewCell {
    
    var app: AppResult? {
        didSet {
            appIconImageView.setAppIcon(iconUrl: app?.artworkUrl100 ?? "")
            appNameLabel.text = app?.name
            companyLabel.text = app?.artistName
        }
    }
    
    let appIconImageView = AppIconImageView(size: 64, cornerRadius: 12)
    let appNameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 18), numberOfLines: 2)
    let companyLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 13))
    
    let getButton = GetButton(text: "GET", backgroundColor: getButtonColor, textColor: .blue)
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.backgroundColor = .clear
        companyLabel.textColor = .lightGray
        
        let labelStackView = VerticalStackView(arrangedSubviews: [
            appNameLabel,
            companyLabel
        ], spacing: 4)
        
        let stackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            labelStackView,
            getButton,
        ] , spacing: 12)
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: labelStackView.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
