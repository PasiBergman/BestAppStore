//
//  TodayAppsCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 27.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayAppsCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem?.category
            titleLabel.text = todayItem?.title
        }
    }
    
    let categoryLabel = UILabel(text: "CATEGORY", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    let todayAppsController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .white
        todayAppsController.view.backgroundColor = .red
        
        layer.cornerRadius = todayCellCornerRadius
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            todayAppsController.view
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
