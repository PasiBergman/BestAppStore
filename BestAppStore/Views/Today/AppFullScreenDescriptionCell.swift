//
//  AppFullScreenDescriptionCell.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 26.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class AppFullScreenDescriptionCell: UITableViewCell {
    
    
    var descriptionTexts = [String]() {
        didSet {
            let attributedText = NSMutableAttributedString(string: "\n")
            for (index, element) in descriptionTexts.enumerated() {
                if index % 2 == 0 {
                    attributedText.append(NSAttributedString(string: element, attributes: [.foregroundColor: UIColor.black]))
                } else {
                    attributedText.append(NSAttributedString(string: element + "\n\n", attributes: [.foregroundColor: UIColor.gray]))
                }
            }
            descriptionLabel.attributedText = attributedText
        }
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel(text: "", font: .systemFont(ofSize: 20), numberOfLines: 0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 0, left: 24, bottom: 48, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
