//
//  SearchResult.swift
//  AppStore
//
//  Created by Seth Danner on 4/24/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
}
