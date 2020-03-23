//
//  SearchController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 22.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var softwareResults = [SoftwareResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = searchBackgroundColor
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchCollectionViewCellId)
        
        fetchITunesApps()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 360)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCellId, for: indexPath) as! SearchResultCell
        cell.softwareResult = softwareResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return softwareResults.count
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Fileprivate
    
    fileprivate func fetchITunesApps(searchTerm: String = "Instagram") {
        ApiService.shared.searchApps(searchTerm: searchTerm, completion: { (searchResults, err) in
            if let err = err {
                print("Failed to fetch search results:", err)
                return
            }
            self.softwareResults = searchResults
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}
