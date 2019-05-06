//
//  AppGroup.swift
//  AppStore
//
//  Created by Seth Danner on 4/26/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    
    let feed: Feed
}

struct Feed: Decodable {
    
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    
    let id, name, artistName, artworkUrl100: String
}
