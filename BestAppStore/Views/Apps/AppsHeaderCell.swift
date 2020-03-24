//
//  AppsHeaderCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 24.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppsHeaderHeader: UICollectionViewCell {
    
    let companyLabel: UILabel = {
        let label = UILabel(text: "Company", font: UIFont.systemFont(ofSize: 12))
        label.textColor = .blue
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(text: "Keeping up with friends is faster than ever", font: UIFont.systemFont(ofSize: 24))
        return label
    }()
    
    let appImageView: UIImageView = {
        let iv = UIImageView(cornerRadius: 8)
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        titleLabel.numberOfLines = 2
        
        let stackView = VerticalStackView(arrangedSubviews: [
            companyLabel,
            titleLabel,
            appImageView
        ])
        stackView.spacing = 12
            
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
