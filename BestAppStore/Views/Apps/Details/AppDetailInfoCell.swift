//
//  AppDetailCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppDetailInfoCell: UICollectionViewCell {
    
    var appData: SoftwareResult? {
        didSet {
            nameLabel.text = appData?.trackName
            priceButton.setTitle(appData?.formattedPrice, for: .normal)
            releaseNotesLabel.text = appData?.releaseNotes
            appIconImageView.setAppIcon(iconUrl: appData?.artworkUrl100 ?? "")
        }
    }
    
    let appIconImageView = AppIconImageView(size: appDetailIconWidthHeight, cornerRadius: appDetailIconCornerRadius)
    let nameLabel = UILabel(text: "Application Detail Title", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = GetButton(text: "Free", backgroundColor: #colorLiteral(red: 0.1659104228, green: 0.4678452015, blue: 0.9698354602, alpha: 1), textColor: .white)
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 22))
    let releaseNotesLabel = UILabel(text: "1.More emoticons \n2.Send iMessage & MMS much more easier", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // backgroundColor = .white
        
        let nameAndPriceStackView = VerticalStackView(arrangedSubviews: [
            nameLabel,
            UIStackView(arrangedSubviews: [priceButton, UIView()]),
            UIView(),
        ], spacing: 12)
        
        let topStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            nameAndPriceStackView,
        ], spacing: 12)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            topStackView,
            whatsNewLabel,
            releaseNotesLabel,
        ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
