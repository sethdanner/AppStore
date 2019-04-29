//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Seth Danner on 4/23/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellID = "searchResultsCell"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
        
//        fetchITunesApps()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // Introduce some delay before performing the search
        // Throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            // This will actually fire the search
            AppService.shared.fetchApps(searchTerm: searchText) { (res, error) in
                self.appResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    fileprivate var appResults = [Result]()
    
    fileprivate func fetchITunesApps() {
        
        AppService.shared.fetchApps(searchTerm: "twitter") { (res, error) in
            
            if let error = error {
                print("Failed to fetch apps:", error)
                return
            }
            
            self.appResults = res?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultsCell
        
        let appResult = appResults[indexPath.item]
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        
        let url = URL(string: appResult.artworkUrl100)
        cell.appIconImageView.sd_setImage(with: url)
        
        cell.screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
        
        if appResult.screenshotUrls.count > 1 {
            cell.screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
        }
        
        if appResult.screenshotUrls.count > 2 {
            cell.screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
        }
        
        return cell
    }
}
