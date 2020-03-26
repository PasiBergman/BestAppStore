//
//  SearchResult.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 23.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [SoftwareResult]
}

struct SoftwareResult: Decodable {
    let trackName: String
    let primaryGenreName: String
    var userRatingCount: Int?
    let screenshotUrls: [String]
    let artworkUrl100: String
    let formattedPrice: String
    let description: String
    let releaseNotes: String?
}
