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
    private var pageCount = 1
    private var keyword = ""
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        ImageFlickrAppConfig.shared
        imageSearchCache = ImageDataStore.shared.imageSearchResultCache
        
        //self.refreshControl?.addTarget(self, action: #selector(SearchPhotoCollectionViewController.loadUp), forControlEvents: .ValueChanged)
        
        collectionView.register(UINib(nibName: "SearchDetailPhotoViewController", bundle: Bundle.main), forCellWithReuseIdentifier: "SearchDetailPhotoViewController")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.searchField.smartInsertDeleteType = .no
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imageSearchCache.count - 1 {
            pageCount+=1
            loadTheNextPage()
        }
        
        
    }
    
    // make a call for the next page and append to the collection
    func loadTheNextPage() -> Void {
        let searchTerm = ImageDataStore.shared.setupSearchUrl(keyword: self.keyword, pageNumber: self.pageCount)
        
        ImageDataStore.shared.executeSearch(searchUrl: URL(string: searchTerm)!) { (imageSearchResults) in
            DispatchQueue.global(qos: .default).async { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    
                    for result in imageSearchResults {
                        self!.imageSearchCache.append(result)
                    }
        
                    self!.collectionView.reloadData()
                }
            }
        }
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
        
        let imageSearchResult =  imageSearchCache[indexPath.row]
        
        let searchImage = UIImage(data: imageSearchResult.fetchPhoto(url: imageSearchResult.photoUrl!) as Data)
        
        let sdpVC = SearchDetailPhotoViewController()
        sdpVC.searchImage = searchImage
        present(sdpVC, animated: true, completion: nil)
        
        return true
    }
    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

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
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        let searchTerm = ImageDataStore.shared.setupSearchUrl(keyword: textField.text!, pageNumber: self.pageCount)
        
        ImageDataStore.shared.executeSearch(searchUrl: URL(string: searchTerm)!) { (imageSearchResults) in
            DispatchQueue.global(qos: .default).async { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    
                    self!.imageSearchCache = imageSearchResults
                    
                    activityIndicator.removeFromSuperview()
                    
                    self!.collectionView.reloadData()
                }
            }
        }
        
        keyword = textField.text!
        textField.text = ""
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    

}
