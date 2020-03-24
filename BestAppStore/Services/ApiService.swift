//
//  ApiService.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import Foundation

class ApiService {
    
    // Singleton
    static let shared = ApiService()
    
    func searchApps(searchTerm: String, completion: @escaping ([SoftwareResult], Error?) -> ()) {
        guard let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion([], nil)
            return
        }
        let urlString = "https://itunes.apple.com/search?term=\(encodedSearchTerm)&entity=software"

        guard let url = URL(string: urlString) else {
            completion([], URLError(.unsupportedURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion([], err)
                return
            }
            
            guard let data = data else {
                completion([], nil)
                return
            }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
            } catch let jsonError {
                completion([], jsonError)
            }
            
        }.resume()
    }
    
    func editorsChoiceApps(completion: @escaping (Feed?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/new-apps-we-love/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func topFreeApps(completion: @escaping (Feed?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/top-free/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func topPaidApps(completion: @escaping (Feed?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/top-paid/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func topGrossingApps(completion: @escaping (Feed?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/top-grossing/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    
    fileprivate func fetchAppGroup(urlString: String, completion: @escaping (Feed?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let feedResult = try JSONDecoder().decode(FeedResult.self, from: data)
                
                completion(feedResult.feed, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
            
        }.resume()
    }
}
