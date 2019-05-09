//
//  Reviews.swift
//  AppStore
//
//  Created by Seth Danner on 5/9/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Name
    let title: Label
    let content: Label
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Name: Decodable {
    let name: Label
}

struct Label: Decodable {
    let label: String
}
