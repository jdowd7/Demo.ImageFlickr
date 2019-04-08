//
//  SearchDetailPhotoViewController.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/5/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit

class SearchDetailPhotoViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var imageViewBackground: UIImageView!
    var searchImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup imageViews
        imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        imageViewBackground.backgroundColor = UIColor.clear
        imageViewBackground.isOpaque = false
        imageViewBackground.image = searchImage
        imageViewBackground.contentMode = .scaleAspectFit
        imageViewBackground.clipsToBounds = true
        //imageViewBackground.contentMode = .redraw
        
        //setupScroll with imageBounds
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.clear
        scrollView.isOpaque = false
        scrollView.contentSize = imageViewBackground.bounds.size
        scrollView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // blur
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //add views to main view
        scrollView.addSubview(imageViewBackground)
        view.backgroundColor = UIColor.clear
        view.addSubview(blurEffectView)
        view.isOpaque = false
        view.addSubview(scrollView)
        
        //setup tap recognizer and fire off dismissVC
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: {});
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
