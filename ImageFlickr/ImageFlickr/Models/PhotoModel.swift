//
//  PhotoModel.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/2/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit

struct Photos : Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [PhotoModel]
}

struct PhotoModel: Decodable {
    
    // MARK: Properties
    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var ispublic: Int
    var isfriend: Int
    var isfamily: Int
    
    init?(json: Dictionary<String, Any>) {
        guard let id = json["id"] as? String,
            let owner = json["owner"] as? String,
            let secret = json["secret"] as? String,
            let server = json["server"] as? String,
            let farm = json["farm"] as? Int,
            let title = json["title"] as? String,
            let ispublic = json["ispublic"] as? Int,
            let isfriend = json["isfriend"] as? Int,
            let isfamily = json["isfamily"] as? Int
         else {
            return nil
        }
        
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }

}
