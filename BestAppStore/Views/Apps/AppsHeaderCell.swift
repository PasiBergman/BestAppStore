//
//  AppsHeaderCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 24.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    var socialApp: SocialApp? {
        didSet {
            companyLabel.text = socialApp?.name
            titleLabel.text = socialApp?.tagline
            setAppImageView(socialApp?.imageUrl ?? "")
        }
    }
    
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
        iv.contentMode = .scaleAspectFill
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
    
    fileprivate func setAppImageView(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        appImageView.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
