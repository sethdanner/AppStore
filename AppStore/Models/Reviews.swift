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
//    let rating: Rating
}

struct Name: Decodable {
    let name: Label
}

//struct Rating: Decodable {
//    let rating: Label
//}

struct Label: Decodable {
    let label: String
}




