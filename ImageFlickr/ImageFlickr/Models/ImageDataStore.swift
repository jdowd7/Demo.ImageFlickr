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
    var decoder: JSONDecoder
    var searchKeyword: String
    var imageSearchJSON: PhotoModel?
    var imageSearchResultCache: [ImageSearchResult]
    var searchPages: Int?
    var searchTotal: Int?
    
    init() {
        self.decoder = JSONDecoder()
        self.searchKeyword = ""
        self.imageSearchResultCache = [ImageSearchResult]()
        //self.imageSearchJSON = Photos
        self.searchPages = 0
        self.searchTotal = 0
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
    func setupSearchUrl(keyword: String, pageNumber: Int) -> String {
        validation(keyword)
        let baseUrl = String(format: "%@", AppConstants.FlickrUrls.k_BaseServiceUrl)
        let methodParam = String(format: "?%@=%@", AppConstants.FlickrApiParams.k_method_param, AppConstants.FlickrApiParams.k_FlickrPhotosSearch)
        let apiKeyParam = String(format: "&api_key=%@", AppConstants.FlickrKeys.k_api_key)
        let tagsParam = String(format: "&%@=%@", AppConstants.FlickrApiParams.k_tags, self.searchKeyword)
        let tagModeParam = String(format: "&%@=%@", AppConstants.FlickrApiParams.k_tag_mode, "")
        let perPageParam = String(format: "&%@=%@", AppConstants.FlickrApiParams.k_per_page, AppConstants.FlickrApiParams.k_per_page_value)
        let pageParam = String(format: "&%@=%@", AppConstants.FlickrApiParams.k_page, String(pageNumber)) //AppConstants.FlickrApiParams.k_page_value)
        let formatParam = String(format: "&%@=%@", AppConstants.FlickrApiParams.k_format, AppConstants.FlickrApiParams.k_format_json)
        let noJsonCallbackParam = String(format: "&%@=%@", AppConstants.FlickrApiParams.k_nojsoncallback, AppConstants.FlickrApiParams.k_nojsoncallback_yes)
        
        return baseUrl + methodParam + apiKeyParam + tagsParam + tagModeParam + perPageParam + pageParam + formatParam + noJsonCallbackParam
    }
    
    
    func executeSearch(searchUrl: URL, finished: @escaping (_ imageSearchResults: [ImageSearchResult]) -> Void) {
        let networkManager = NetworkManager(url: searchUrl, httpMethod: "POST", params: [String: String](), headers: [String: String]())
        networkManager.executeJsonRequest { (json) -> () in
            let jsonPhotos = json
            if jsonPhotos.stat != "ok" { return }
            
            self.imageSearchJSON = jsonPhotos
            let processedResults = self.processImages(jsonPhotosList: jsonPhotos)
            finished(processedResults)
        }
    }
    
    //func processImages(jsonPhotosList: [String: Any]) -> Void {
     func processImages(jsonPhotosList: PhotoModel) -> [ImageSearchResult] {
       
        self.searchPages = jsonPhotosList.photos?.pages
        self.searchTotal = jsonPhotosList.photos?.total
        
        if searchTotal == 0 { return [ImageSearchResult]() }
        
        let jsonPhotoList = (jsonPhotosList.photos?.photo)!
        
        self.imageSearchResultCache = [ImageSearchResult]()
        
        for jsonPhoto in jsonPhotoList {
            self.imageSearchResultCache.append(ImageSearchResult(id: jsonPhoto.id!, owner: jsonPhoto.owner!, secret: jsonPhoto.secret!, server: jsonPhoto.server!, farm: jsonPhoto.farm!, title: jsonPhoto.title!, ispublic: jsonPhoto.ispublic!, isfriend: jsonPhoto.isfriend!, isfamily: jsonPhoto.isfamily!, keyword: self.searchKeyword))
        }
        print("Cache Contains: %@", self.imageSearchResultCache.count)
        return self.imageSearchResultCache
    }
    
    fileprivate func validation(_ keyword: String) {
        if keyword.trimmingCharacters(in: .whitespaces).isEmpty {
            self.searchKeyword  = "Stop"
        } else {
            self.searchKeyword = keyword
            ImageFlickrAppConfig.shared.storeSearchKeyword(keyword: self.searchKeyword)
        }
    }
    
    
    
}
