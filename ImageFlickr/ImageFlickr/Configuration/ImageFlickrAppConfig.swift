//
//  ImageFlickrAppConfig.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/7/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import Foundation

class ImageFlickrAppConfig {

    static let shared = ImageFlickrAppConfig()
    var userDefaults = UserDefaults.standard
    
    var searchHistoryCache: [String]?
    
    init() {
        self.searchHistoryCache = self.loadSearchHistory()
    }
    
    public func storeSearchKeyword(keyword: String) -> Void {
        self.searchHistoryCache?.append(keyword)
        self.saveSearchHistory()
    }
    
    func loadSearchHistory() -> [String] {
        return userDefaults.stringArray(forKey: AppConstants.AppConfigConstants.k_searchHistoryCache) ?? [String]()
    }
    
    func saveSearchHistory() -> Void {
        userDefaults.set(searchHistoryCache, forKey: AppConstants.AppConfigConstants.k_searchHistoryCache)
    }
    
}
