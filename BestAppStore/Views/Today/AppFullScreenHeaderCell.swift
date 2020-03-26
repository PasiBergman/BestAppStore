//
//  AppFullScreenHeaderCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 27.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    var didClickCloseButton: (() -> ())?
    
    let todayCell = TodayCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.layer.cornerRadius = 0
        todayCell.fillSuperview()
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
        
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchDown)
    }
    
    @objc fileprivate func closeButtonClicked(button: UIButton) {
        button.isHidden = true
        didClickCloseButton?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
