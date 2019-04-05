//
//  SearchPhotoCollectionViewController.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/1/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit



class SearchPhotoCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    var imageSearchCache : [ImageSearchResult] = []
    private let reuseIdentifier = "imageSearchResultCell"
    
    @IBOutlet weak var searchField: UITextField!
    
    var largePhotoIndexPath: IndexPath? {
        didSet {
            // 2
            var indexPaths: [IndexPath] = []
            if let largePhotoIndexPath = largePhotoIndexPath {
                indexPaths.append(largePhotoIndexPath)
            }
            
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            // 3
            collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: indexPaths)
            }) { _ in
                // 4
                if let largePhotoIndexPath = self.largePhotoIndexPath {
                    self.collectionView.scrollToItem(at: largePhotoIndexPath,
                                                     at: .centeredVertically,
                                                     animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imageSearchResultCell")

        // Do any additional setup after loading the view.
        
        imageSearchCache = ImageDataStore.shared.imageSearchResultCache
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.searchField.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: 120)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageSearchCache.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageSearchResultCell", for: indexPath) as! SearchPhotoCollectionViewCell
        cell.setUp(model: imageSearchCache[indexPath.row])
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
      /*  if largePhotoIndexPath == indexPath {
            largePhotoIndexPath = nil
        } else {
            largePhotoIndexPath = indexPath
        }
        
        return false
      */
        let imageSearchResult =  imageSearchCache[indexPath.row]
        
        let spcVC = storyboard!.instantiateViewController(withIdentifier: "SearchPhotoCollectionViewController") as? SearchPhotoCollectionViewController
        let spdVC = storyboard!.instantiateViewController(withIdentifier: "SearchPhotoDetailViewController") as? SearchPhotoDetailViewController
        let navController = UINavigationController(rootViewController: spdVC!)
        
        imageSearchResult.fetchLargePhoto(url: imageSearchResult.photoUrl!) { (photoData) in
            print("fetchedMainImage")
        }
        
        spdVC?.selectedImageSearchResult = imageSearchResult
        spdVC!.modalTransitionStyle = .crossDissolve
        spdVC!.modalPresentationStyle = .popover
        navController.pushViewController(spcVC!, animated: true)
        
        self.present(navController, animated: true, completion: nil)
        navController.popViewController(animated: true)
        
        return false
    }
    

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
        /*
        let storyboard = UIStoryboard(name: "SearchPhotoDetailViewController", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchPhotoDetailViewController")
        controller.searchPhoto
        
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overCurrentContext
         self.present(controller, animated: true, completion: nil)
        
        let imageSearchResult =  imageSearchCache[indexPath.row]
        
        let spcVC = storyboard!.instantiateViewController(withIdentifier: "SearchPhotoCollectionViewController") as? SearchPhotoCollectionViewController
        let spdVC = storyboard!.instantiateViewController(withIdentifier: "SearchPhotoDetailViewController") as? SearchPhotoDetailViewController
        let navController = UINavigationController(rootViewController: spdVC!)
        
        spdVC!.photoUrl = imageSearchResult.photoUrl
        
        spdVC!.modalTransitionStyle = .crossDissolve
        spdVC!.modalPresentationStyle = .popover
        navController.pushViewController(spcVC!, animated: true)
        
        present(navController, animated: true, completion: nil)
         */
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let imageWidth = view.frame.width - (UIEdgeInsets(top: 54.0, left: 24.00, bottom: 54.00, right: 24.0).left * (2 + 1))
        //let widthPerItem = 150 / 2
        return CGSize(width: 184, height:230)
    }
 
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 16.00, bottom: 1.00, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return UIEdgeInsets(top: 1.0, left: 16.00, bottom: 16.00, right: 16.0).top
    }
    
    // MARK: TextView Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let searchTerm = ImageDataStore.shared.setupSearchUrl(searchKeyword: textField.text!)
        
        ImageDataStore.shared.executeSearch(searchUrl: URL(string: searchTerm)!) { (imageSearchResults) in
            self.imageSearchCache = imageSearchResults
            
            DispatchQueue.global(qos: .default).async { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self!.collectionView.reloadData()
                }
            }
        }
        
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    

}
