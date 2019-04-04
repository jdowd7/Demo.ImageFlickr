//
//  SearchPhotoCollectionViewCell.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/1/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit

class SearchPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var spcImage: UIImageView!
    @IBOutlet var spcTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUp(model: ImageSearchResult) {
        
        spcImage.image = model.photoThumbImage
        spcTextLabel.text = model.title
        spcTextLabel.textColor = .black
        /*
            DispatchQueue.global(qos: .default).async { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self!.spcImage.image = model.photoThumbImage
                self!.spcTextLabel.text = model.title
            }
        }
        */
    }
}
