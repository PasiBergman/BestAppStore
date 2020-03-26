//
//  ReviewCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    var appReview: ReviewEntry? {
        didSet {
            titleLabel.text = appReview?.title.label
            authorLabel.text = appReview?.author.name.label
            bodyLabel.text = appReview?.content.label
            hideRatingStars(rating: appReview?.rating.label ?? "")
        }
    }
    
    let titleLabel = UILabel(text: "Great app with features", font: .boldSystemFont(ofSize: 14), numberOfLines: 1)
    let authorLabel = UILabel(text: "Anonymous", font: .systemFont(ofSize: 14))
    // let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "Nullam id elit interdum.", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    let starsStackView: UIStackView = {
        var starViews = [UIView]()
        (0..<5).forEach { (_) in
            let starImageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            starImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
            starViews.append(starImageView)
        }
        starViews.append(UIView())
        
        let sv = UIStackView(arrangedSubviews: starViews)
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(white: 0.90, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        authorLabel.textColor = .lightGray
        
        let titleStack = UIStackView(arrangedSubviews: [
            titleLabel,
            UIView(),
            authorLabel,
        ], spacing: 2)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            titleStack,
            starsStackView,
            SpacerView(space: 4),
            bodyLabel,
            UIView(),
        ], spacing: 6)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))

    }
    
    fileprivate func hideRatingStars(rating: String) {
        let ratingInt = Int(rating) ?? 0
        
        for (index, view) in starsStackView.arrangedSubviews.enumerated() {
            view.alpha = index >= ratingInt ? 0 : 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
