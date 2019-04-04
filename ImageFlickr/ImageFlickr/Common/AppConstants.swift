//
//  AppConstants.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 3/30/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import Foundation

struct AppConstants {
    
    // MARK: API Keys
    struct FlickrKeys {
        static let k_api_key = "1508443e49213ff84d566777dc211f2a"
    }
    // MARK: URL Constants
    /* Get Pic URL Docs
       www.flickr.com/services/api/misc.urls.html
       get pic url: farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
       get pic url size: farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
     */
    struct FlickrUrls {
        // Base Url
        static let k_BaseServiceUrl = "https://api.flickr.com/services/rest/"
        static let k_StaticFlickrBaseUrl = "staticflickr.com"
        
    }
    // MARK: Photo Search Params
    /* Search Photos by Keyword Docs
     api.flickr.com/services/rest/
     ?method=flickr.photos.search
     &api_key=b35fda5e4acbd587ae9ec6ffbe9ce41c
     &tags=dogs
     &tag_mode=
     &per_page=90
     &page=1
     &format=json
     &nojsoncallback=1
     */
    struct FlickrApiParams {
        static let k_method_param = "method"
        static let k_FlickrPhotosSearch = "flickr.photos.search"
        static let k_tags = "tags"
        static let k_tag_mode = "tag_mode"
        static let k_per_page = "per_page"
        static let k_per_page_value = "25"
        static let k_page = "page"
        static let k_page_value = "1"
        static let k_format = "format"
        static let k_format_json = "json"
        static let k_nojsoncallback = "nojsoncallback"
        static let k_nojsoncallback_yes = "1"
    }
}
