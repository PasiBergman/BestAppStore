//
//  SearchController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 22.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class SearchController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var appResults = [SoftwareResult]()
    
    fileprivate let appSearchController = UISearchController(searchResultsController: nil)
    fileprivate let noSearchResultsLabel: UILabel = {
        let label = UILabel(text: noSearchResultsLabelText, font: .systemFont(ofSize: 20, weight: .regular))
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = searchBackgroundColor
        
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchCollectionViewCellId)
        
        setupSearchResultLabel()
        setupSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //  timer?.invalidate()
        let searchText = searchBar.text ?? ""
        fetchITunesApps(searchTerm: searchText)
        appSearchController.isActive = false
        searchBar.text = searchText
    }
    
//    var timer: Timer?

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        timer?.invalidate()
//
//        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false, block: { (_) in
//            self.fetchITunesApps(searchTerm: searchText)
//        })
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 320)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCellId, for: indexPath) as! SearchResultCell
        cell.softwareResult = appResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        noSearchResultsLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging")
//        let searchText = appSearchController.searchBar.text
//        appSearchController.isActive = false
//        appSearchController.searchBar.text = searchText
//    }

    // MARK: - Fileprivate
    
    fileprivate func setupSearchResultLabel() {
        view.addSubview(noSearchResultsLabel)
        noSearchResultsLabel.fillSuperview()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.appSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        // appSearchController.dimsBackgroundDuringPresentation = false
        appSearchController.searchBar.delegate = self
    }
    
    fileprivate func fetchITunesApps(searchTerm: String) {
        if searchTerm == "" {
            appResults = [SoftwareResult]()
            collectionView.reloadData()
            return
        }
                
        ApiService.shared.searchApps(searchTerm: searchTerm, completion: { (searchResults, err) in
            if let err = err {
                print("Failed to fetch search results:", err)
                return
            }
            self.appResults = searchResults
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}
