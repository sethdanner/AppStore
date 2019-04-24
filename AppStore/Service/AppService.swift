//
//  AppService.swift
//  AppStore
//
//  Created by Seth Danner on 4/24/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import Foundation

class AppService {
    
    static let shared = AppService() // singleton
    
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        print("Fetching iTunes apps from Service layer")
        
        let urlString  = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch apps:", error)
                completion([], nil)
                return
            }
            
            // success
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results, nil)
            } catch let jsonError {
                print("Failed to decode json:", jsonError)
                completion([], nil)
            }
            
            }.resume() // fires off the request
    }
}
