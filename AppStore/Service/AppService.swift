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
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        print("Fetching iTunes apps from Service layer")
        
        let urlString  = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json", completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json", completion: completion)
    }
    
    // Helper for fetching TopGrossing, Games, and TopFree groups.
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    // Decare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        print("T is type:", T.self)
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let socialApps = try JSONDecoder().decode(T.self, from: data)
                // Success
                completion(socialApps, nil)
            } catch {
                completion(nil, error)
            }
            
            }.resume() // This fires off the request
    }
}
