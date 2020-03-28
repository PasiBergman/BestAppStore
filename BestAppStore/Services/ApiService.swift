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
    
    func searchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        guard let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(nil, URLError(.unsupportedURL))
            return
        }
        let urlString = "https://itunes.apple.com/search?term=\(encodedSearchTerm)&entity=software"

        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func editorsChoiceApps(completion: @escaping (FeedResult?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/new-apps-we-love/all/50/explicit.json"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func topFreeApps(completion: @escaping (FeedResult?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/top-free/all/50/explicit.json"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func topPaidApps(completion: @escaping (FeedResult?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/top-paid/all/50/explicit.json"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func topGrossingApps(completion: @escaping (FeedResult?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/top-grossing/all/50/explicit.json"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchAppDetails(appId: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        if appId.isEmpty {
            completion(nil, URLError(.unsupportedURL))
            return
        }
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func editorsChoiceGames(completion: @escaping (FeedResult?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/fi/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    
    func fetchAppRevies(appId: String, completion: @escaping (ReviewsData?, Error?) -> ()) {
        if appId.isEmpty {
            completion(nil, URLError(.unsupportedURL))
            return
        }
        let urlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    fileprivate func fetchGenericJsonData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            print("Unsupported url: \(urlString)")
            completion(nil, URLError(.unsupportedURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let data = data else {
                print("Invalid data in fetchGenericJsonData for \(urlString) - response:", resp)
                completion(nil, nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                completion(result, nil)
            } catch let jsonError {
                completion(nil, jsonError)
            }
            
        }.resume()
    }
}
