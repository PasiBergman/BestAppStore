//
//  ApiService.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import Foundation

class ApiService {
    
    static let shared = ApiService() // Singleton
    
    func searchApps(searchTerm: String = "Instagram", completion: @escaping ([SoftwareResult], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion([], err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
            } catch let jsonError {
                completion([], jsonError)
            }
            
        }.resume()
    }
}
