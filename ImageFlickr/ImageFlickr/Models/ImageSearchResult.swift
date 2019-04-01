//
//  ImageSearchResult.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 3/30/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import Foundation
import UIKit

class ImageSearchResult {
    
    // MARK: Properties
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: String
    var title: String
    var ispublic: String
    var isfriend: String
    var isfamily: String
    var keyword: String
    var url: URL?
    var image: UIImage?
    
    // MARK: Constructor
    init(id: String, owner: String, secret: String, server: String, farm: String, title: String, ispublic: String, isfriend: String, isfamily: String, keyword: String, url: String = "") {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
        self.keyword = keyword
        self.url = createImageUrl(imgId: id, farmId: farm, secretId: secret, serverId: server, mstzb: "")
        fetchImage(url: self.url!) { success in
            print("fetchCompleted")
        }
    }
    
    // MARK: Instance Methods
    func createImageUrl(imgId: String, farmId: String, secretId: String, serverId: String, mstzb: String) -> URL {
        //get pic url: farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        return URL(string: String(format: "https://farm%@.%@/%@/%@_%@.jpg", farmId, AppConstants.FlickrUrls.k_StaticFlickrBaseUrl, serverId, imgId,secretId))!
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func fetchImage(url: URL, completion: (_ success: String?) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
        completion("YES")
    }
}

