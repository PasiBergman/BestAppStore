//
//  ReviewsData.swift
//  BestAppStore
//
//  Created by Pasi Bergman on 25.3.2020.
//  Copyright © 2020 Pasi Bergman. All rights reserved.
//

import Foundation

struct ReviewsData: Decodable {
    var feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    var entry: [ReviewEntry]?
}

struct ReviewEntry: Decodable {
    var author: ReviewAuthor
    var title: ReviewLabel
    var rating: ReviewLabel
    var content: ReviewLabel
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct ReviewAuthor: Decodable {
    var name: ReviewLabel
}

struct ReviewLabel: Decodable {
    var label: String
}
