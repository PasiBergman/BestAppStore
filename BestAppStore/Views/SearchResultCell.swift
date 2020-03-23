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
            setAppIconImage(softwareResult?.artworkUrl100)
            setScreenShotImages(softwareResult?.screenshotUrls ?? [])
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        return label
    }()

    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.56M"
        return label
    }()
    
    let getButton: UIButton = {
        let  btn = UIButton(type: .system)
        btn.setTitle("GET", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.layer.cornerRadius = 16
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return btn
    }()
    
    lazy var screenShot1ImageView = self.createScreeShotImgageView()
    lazy var screenShot2ImageView = self.createScreeShotImgageView()
    lazy var screenShot3ImageView = self.createScreeShotImgageView()
        
    func createScreeShotImgageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = searchResultScreenShotBackgroundColor
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
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
        ])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [
            screenShot1ImageView,
            screenShot2ImageView,
            screenShot3ImageView,
        ])
        screenShotsStackView.spacing = 12
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
    
    fileprivate func setAppIconImage(_ iconUrl: String?) {
        guard let url = URL(string: iconUrl ?? "") else { return }
        appIconImageView.sd_setImage(with: url)
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
