//
//  SearchController.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 22.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import UIKit

class SearchController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var searchResults = [SoftwareResult]()
    
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
        let searchText = searchBar.text ?? ""
        fetchITunesApps(searchTerm: searchText)
        appSearchController.isActive = false
        searchBar.text = searchText
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 320)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewCellId, for: indexPath) as! SearchResultCell
        cell.softwareResult = searchResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        noSearchResultsLabel.isHidden = searchResults.count != 0 || activityIndicator.isAnimating
        return searchResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appDetailController = AppDetailController()
        appDetailController.appId = "\(searchResults[indexPath.item].trackId)"
        navigationController?.pushViewController(appDetailController, animated: true)
    }
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
    
    fileprivate func prepareForSearch() {
        activityIndicator.startAnimating()
        searchResults = [SoftwareResult]()
        collectionView.reloadData()
    }
    
    fileprivate func endSearch() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func fetchITunesApps(searchTerm: String) {
        if searchTerm.isEmpty {
            searchResults = [SoftwareResult]()
            collectionView.reloadData()
            return
        }
        
        prepareForSearch()
        
        ApiService.shared.searchApps(searchTerm: searchTerm, completion: {
            (data, err) in
            if let err = err {
                print("Failed to fetch search results:", err)
            } else {
                if let res = data?.results {
                    self.searchResults = res
                }
            }
            self.endSearch()
        })
    }
}
