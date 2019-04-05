//
//  SearchPhotoDetailViewController.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/5/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit

class SearchPhotoDetailViewController: UIViewController {

    @IBOutlet var searchDetailPhoto: UIButton!
    var photoUrl: URL?
    var selectedImageSearchResult: ImageSearchResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //downloadImage(url: self.photoUrl!)
        setButtonImage(withImage: selectedImageSearchResult!.photoImage!)
        
    }
    
    func setButtonImage(withImage: UIImage) -> Void {
        self.searchDetailPhoto.setImage(withImage, for: .normal)
    }

    func loadPhotoFromUrl() -> UIImage {
        guard let photoData = NSData(contentsOf: self.photoUrl!) else { return UIImage() }
        return UIImage(data: photoData as Data)!
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
  
    
    func downloadImage(url: URL){
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                self.searchDetailPhoto.setImage(UIImage(data: data), for: .normal)
            }
        }
    }
 
    
    @IBAction func pressMeDown(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
