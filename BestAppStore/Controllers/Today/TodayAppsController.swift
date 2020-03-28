//
//  TodayAppsController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 27.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class TodayAppsController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let multipleAppsCellId = "multipleAppsCell"
    
    let closeButton = CloseButton()
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small
        case fullscreen
    }
    
    var apps: [AppResult]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        if mode == .small {
            collectionView.isScrollEnabled = false
        } else {
            navigationController?.isNavigationBarHidden = true
        }
        
        collectionView.register(MultipleAppsCell.self, forCellWithReuseIdentifier: multipleAppsCellId)
        
        setupCloseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if mode == .fullscreen {
            navigationController?.isNavigationBarHidden = true
        }
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true) {
            //
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let app = apps![indexPath.item]
        
        let appDetailController = AppDetailController(appId: app.id, appTitle: app.name)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if mode == .fullscreen {
            return apps?.count ?? 0
        } else {
            return min(4, apps?.count ?? 0)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppsCellId, for: indexPath) as! MultipleAppsCell
        
        cell.app = apps?[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var cellHeight: CGFloat = 64
        var cellWidth: CGFloat = collectionView.frame.width
        
        if mode == .small {
            cellHeight = (collectionView.frame.height - 3 * lineSpacing) / 4
        } else {
            cellWidth = cellWidth - 2 * horizontalScollLeftRightPadding
        }
        return .init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 64, left: horizontalScollLeftRightPadding, bottom: 20, right: horizontalScollLeftRightPadding)
        }
        return .zero
    }
    
    let lineSpacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    fileprivate func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        if mode == .fullscreen {
            view.addSubview(closeButton)
            closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
        }
    }
}
