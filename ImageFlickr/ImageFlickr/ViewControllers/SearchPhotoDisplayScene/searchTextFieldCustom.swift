//
//  searchTextField.swift
//  ImageFlickr
//
//  Created by Jake O'Dowd on 4/8/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import UIKit

class searchTextFieldCustom: UITextField, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    
    func createSearchHistoryTable() -> Void {
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchTextFieldCustom")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)
            
        } else {
            print("tableView created")
            tableView = UITableView(frame: CGRect.zero)
        }
        updateSearchHistoryTable()
    }
    
    func updateSearchHistoryTable() -> Void {
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            // Set a bottom margin of 10p
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        createSearchHistoryTable()
    }
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(searchTextFieldCustom.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(searchTextFieldCustom.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(searchTextFieldCustom.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(searchTextFieldCustom.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }
    
    // MARK: TextView Obj-c Methods
    @objc open func textFieldDidChange(){
        print("Text changed ...")
        //addData()
        updateSearchHistoryTable()
        
    }
    
    @objc open func textFieldDidBeginEditing() {
        print("Begin Editing")
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidEndEditing() {
        print("End editing")
        tableView?.isHidden = true
    }
    
    @objc open func textFieldDidEndEditingOnExit() {
        print("End on Exit")
    }
    
    // MARK: TableViewDataSource Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageFlickrAppConfig.shared.searchHistoryCache!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTextFieldCustom", for: indexPath) as UITableViewCell
        cell.backgroundColor = .clear
        cell.textLabel?.text = ImageFlickrAppConfig.shared.searchHistoryCache?[indexPath.row]
        return cell
    }
    
    // MARK: TableViewDelegate Methods
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.text = ImageFlickrAppConfig.shared.searchHistoryCache?[indexPath.row]
        tableView.isHidden = true
        self.endEditing(true)
    }
    

}
