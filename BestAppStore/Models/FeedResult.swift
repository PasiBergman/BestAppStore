//
//  AppResult.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 24.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import Foundation

struct FeedResult: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let country: String
    let results: [AppResult]
}

struct AppResult: Decodable {
    let id: String
    let artistName: String
    let name: String
    let kind: String
    let artworkUrl100: String
}
