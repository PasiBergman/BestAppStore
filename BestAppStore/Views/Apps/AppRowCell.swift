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
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    let spacing: CGFloat = 16
    
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
        stackView.spacing = spacing
        stackView.alignment = .center

        addSubview(stackView)
        stackView.fillSuperview()
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: labelsStackView.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -spacing/2, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fileprivate

}
