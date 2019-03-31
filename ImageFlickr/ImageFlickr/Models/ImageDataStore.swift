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
    
    fileprivate let downloadQueue = DispatchQueue(label: "Images cache", qos: DispatchQoS.background)
    
    private init() { }
    
    
    func processImages(imageSearchResult: [ImageSearchResult]) -> Void {
        
    }
}
