//
//  TodayCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
            descriptionLabel.text = todayItem?.description
            todayImageView.image = todayItem?.image
            backgroundColor = todayItem?.backgroundColor
            backgroundView?.backgroundColor = todayItem?.backgroundColor
        }
    }
    
    var topConstraint: NSLayoutConstraint?
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 24))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligentry organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    let todayImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "garden"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        layer.cornerRadius = todayCellCornerRadius
        backgroundColor = .white
        
        let containerView = UIView()
        containerView.addSubview(todayImageView)
        todayImageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            containerView,
            descriptionLabel
        ], spacing: 8)
        
        addSubview(verticalStackView)
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        topConstraint = verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
