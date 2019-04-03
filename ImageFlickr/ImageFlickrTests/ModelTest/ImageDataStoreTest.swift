//
//  ImageDataStoreTest.swift
//  ImageFlickrTests
//
//  Created by Jake O'Dowd on 4/1/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import XCTest
@testable import ImageFlickr

class ImageDataStoreTest: XCTestCase {

    var imageDataStore_TestInstance : ImageDataStore?
    
    override func setUp() {
        super.setUp()
        self.imageDataStore_TestInstance = ImageDataStore()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageDataStore_executeSearch_ShouldReturnJsonResult() {
        //Arrange
        let url = URL(string:"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1508443e49213ff84d566777dc211f2a&tags=dogs&tag_mode=&per_page=90&page=1&format=json&nojsoncallback=1")
        let expect = self.expectation(description: "jsonFetch")
        
        //Act
        self.imageDataStore_TestInstance?.executeSearch(searchUrl: url!) { (jsonResult) in
            self.imageDataStore_TestInstance?.imageSearchJSON = jsonResult
            expect.fulfill()
        }
        
        //Assert
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssert(self.imageDataStore_TestInstance?.imageSearchJSON != nil)
    }
    
    func testImageDataStore_executeSearch_ShouldPopulateCache() {
        //Arrange
        let url = URL(string:"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1508443e49213ff84d566777dc211f2a&tags=dogs&tag_mode=&per_page=90&page=1&format=json&nojsoncallback=1")
        let expect = self.expectation(description: "jsonFetch")
        
        //Act
        self.imageDataStore_TestInstance?.executeSearch(searchUrl: url!) { (jsonResult) in
            self.imageDataStore_TestInstance?.imageSearchJSON = jsonResult
            expect.fulfill()
        }
        
        //Assert
        waitForExpectations(timeout: 90, handler: nil)
        XCTAssert((self.imageDataStore_TestInstance?.imageSearchResultCache?.count)! > 0)
    }
}
