//
//  BaseListController.swift
//  AppStore
//
//  Created by Seth Danner on 4/25/19.
//  Copyright © 2019 Seth Danner. All rights reserved.
//

import UIKit

// This class allows us to remove the 2 init's below from each of the 3 tab controllers- AppsController, AppsSearchController, and TodayController, making for cleaner code by not repeating in each of the controllers.

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

