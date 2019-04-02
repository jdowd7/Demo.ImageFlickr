//
//  SearchPhotoCollectionViewCell.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/1/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit

class SearchPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var spcImage: UIImageView!
    @IBOutlet weak var spcTextLabel: UILabel!
    
    public func setUp(viewModel: SearchPhotoViewModel) {
        spcImage.image = viewModel.imagePhoto
        spcTextLabel.text = viewModel.imageTitle
    }
}
