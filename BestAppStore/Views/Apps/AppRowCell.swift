//
//  AppRowCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let iconImageView: UIImageView = {
        let iv = UIImageView(cornerRadius: appIconCornerRadius)
        iv.widthAnchor.constraint(equalToConstant: appIconWidthHeight).isActive = true
        iv.heightAnchor.constraint(equalToConstant: appIconWidthHeight).isActive = true
        iv.backgroundColor = .purple
        return iv
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
        label.textColor = .lightGray
        return label
    }()
    
    let getButton: UIButton = {
        let btn = UIButton(title: "GET")
        btn.widthAnchor.constraint(equalToConstant: getButtonWidth).isActive = true
        btn.heightAnchor.constraint(equalToConstant: getButtonHeight).isActive = true
        btn.backgroundColor = getButtonColor
        btn.layer.cornerRadius = getButtonHeight / 2
        btn.clipsToBounds = true
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            appNameLabel,
            companyLabel,
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
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
}
