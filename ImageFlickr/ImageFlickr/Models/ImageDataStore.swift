//
//  ImageDataStore.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 3/31/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import Foundation


class ImageDataStore {
    
    static let shared = ImageDataStore()
    var imageSearchJSON : Dictionary<String, Any>
    var imageSearchResultCache: [ImageSearchResult]

    init() {
        self.imageSearchResultCache = [ImageSearchResult]()
        self.imageSearchJSON = Dictionary<String, Any>()
    }
    
    /* Search Photos by Keyword Docs
     api.flickr.com/services/rest/
     ?method=flickr.photos.search
     &api_key=1508443e49213ff84d566777dc211f2a
     &tags=dogs
     &tag_mode=
     &per_page=90
     &page=1
     &format=json
     &nojsoncallback=1
     */
    func setupSearchUrl(searchKeyword: String) -> String {
        let baseUrl = String(format: "@%", AppConstants.FlickrUrls.k_BaseServiceUrl)
        let methodParam = String(format: "?@%=@%", AppConstants.FlickrApiParams.k_method_param, AppConstants.FlickrApiParams.k_FlickrPhotosSearch)
        let apiKeyParam = String(format: "&api_key=@%", AppConstants.FlickrKeys.k_api_key)
        let tagsParam = String(format: "&@%=@%", AppConstants.FlickrApiParams.k_tags, searchKeyword)
        let tagModeParam = String(format: "&@%=@%", AppConstants.FlickrApiParams.k_tag_mode, "")
        let perPageParam = String(format: "&@%=@%", AppConstants.FlickrApiParams.k_per_page, AppConstants.FlickrApiParams.k_per_page_value)
        let pageParam = String(format: "&@%=@%", AppConstants.FlickrApiParams.k_page, AppConstants.FlickrApiParams.k_page_value)
        let formatParam = String(format: "&@%=@%", AppConstants.FlickrApiParams.k_format, AppConstants.FlickrApiParams.k_format_json)
        let noJsonCallbackParam = String(format: "&@%=@%", AppConstants.FlickrApiParams.k_nojsoncallback, AppConstants.FlickrApiParams.k_nojsoncallback_yes)
        
        return baseUrl + methodParam + apiKeyParam + tagsParam + tagModeParam + perPageParam + pageParam + formatParam + noJsonCallbackParam
    }
    
    
    func executeSearch(searchUrl: URL, finished: @escaping (_ jsonResult: [String: Any]) -> Void) {
        let networkManager = NetworkManager(url: searchUrl, httpMethod: "GET", params: [String: String](), headers: [String: String]())
        networkManager.executeJsonRequest { (json) -> () in
            self.imageSearchJSON = json
            finished(json)
        }
    }
}
