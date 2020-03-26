//
//  SearchCollectionViewCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 22.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    var softwareResult: SoftwareResult? {
        didSet {
            nameLabel.text = softwareResult?.trackName
            categoryLabel.text = softwareResult?.primaryGenreName
            ratingsLabel.text = getFormattedRatingsCount(softwareResult?.userRatingCount)
            appIconImageView.setAppIcon(iconUrl: softwareResult?.artworkUrl100 ?? "")
            setScreenShotImages(softwareResult?.screenshotUrls ?? [])
        }
    }
    
    let appIconImageView = AppIconImageView(size: appIconWidthHeight, cornerRadius: appIconCornerRadius)
    
    let nameLabel: UILabel = {
        let label = UILabel(text: "APP NAME", font: .systemFont(ofSize: 18))
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel(text: "Photo & Video", font: .systemFont(ofSize: 16))
        return label
    }()

    let ratingsLabel: UILabel = {
        let label = UILabel(text: "2.48M", font: .systemFont(ofSize: 16))
        label.textColor = .lightGray
        return label
    }()
    
    let getButton = GetButton(text: "GET", backgroundColor: getButtonColor, textColor: UIColor.blue)
    
    lazy var screenShot1ImageView = self.createScreeShotImgageView()
    lazy var screenShot2ImageView = self.createScreeShotImgageView()
    lazy var screenShot3ImageView = self.createScreeShotImgageView()
        
    func createScreeShotImgageView() -> UIImageView {
        let iv = UIImageView(cornerRadius: 5)
        iv.backgroundColor = searchResultScreenShotBackgroundColor
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return iv
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = searchResultCellBackgroundColor
        
        setupStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupStackViews() {
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            nameLabel,
            categoryLabel,
            ratingsLabel,
        ])
        
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            labelsStackView,
            getButton,
        ], spacing: 12)
        infoTopStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [
            screenShot1ImageView,
            screenShot2ImageView,
            screenShot3ImageView,
        ], spacing: 12)
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [
            infoTopStackView,
            screenShotsStackView,
        ], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func getFormattedRatingsCount(_ ratingsCount: Int?) -> String {
        if let userRatingCount = ratingsCount {
            var userRatingCountText = "\(userRatingCount)"
            if userRatingCount > 999999 {
                let userRatingCountM = (Double(userRatingCount)/Double(1000000)).rounded(toPlaces: 1)
                userRatingCountText = "\(userRatingCountM)M"
            } else if userRatingCount > 999 {
                let userRatingCountK = (Double(userRatingCount)/Double(1000)).rounded(toPlaces: 1)
                userRatingCountText = "\(userRatingCountK)K"
            }
            return userRatingCountText
        } else {
            return "0"
        }
    }
    
    fileprivate func setScreenShotImages(_ screenshotUrls: [String]) {
        if screenshotUrls.count > 0 {
            screenShot1ImageView.sd_setImage(with: URL(string: screenshotUrls[0]))
        }
        if screenshotUrls.count > 1 {
            screenShot2ImageView.sd_setImage(with: URL(string: screenshotUrls[1]))
        }
        if screenshotUrls.count > 2 {
            screenShot3ImageView.sd_setImage(with: URL(string: screenshotUrls[2]))
        }
    }
    
    fileprivate func setScreenShotImage(imageView: UIImageView, screenshotUrl: String) {
        guard let url = URL(string: screenshotUrl) else { return }
        imageView.sd_setImage(with: url)
    }
}
