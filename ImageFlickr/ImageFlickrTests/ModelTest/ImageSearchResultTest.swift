//
//  ImageFlickrTests.swift
//  ImageFlickrTests
//
//  Created by Jake O'Dowd on 3/30/19.
//  Copyright © 2019 Jake O'Dowd. All rights reserved.
//

import XCTest
@testable import ImageFlickr

class ImageSearchResultTest: XCTestCase {
    
    var testControl_ImgSearchResult_1 : ImageSearchResult?
    var testControl_ImgSearchResultUrl : URL?
    
    override func setUp() {
        super.setUp()
        self.testControl_ImgSearchResult_1 = ImageSearchResult(id: "1", owner: "1", secret: "1", server: "1", farm: "1", title: "1", ispublic: "1", isfriend: "1", isfamily: "1", keyword: "1")
        self.testControl_ImgSearchResultUrl = URL(string: "https://farm1.staticflickr.com/1/1_1.png")
    }
    
    override func tearDown() {
        self.testControl_ImgSearchResultUrl = nil
        super.tearDown()
    }
    
    func testImageSearchResult_ContructorValid_ShouldEqualCorrectType() {
        // Arrange & Act
        let imgSearchResult = ImageSearchResult(id: "1", owner: "1", secret: "1", server: "1", farm: "1", title: "1", ispublic: "1", isfriend: "1", isfamily: "1", keyword: "1")
        // Assert
        XCTAssert(imgSearchResult.photoUrl == testControl_ImgSearchResultUrl)
    }
    
    func testImageSearchResult_FetchImage_ShouldReturnValidImage() {
        // Arrange
        let imgSearchResult = ImageSearchResult(id: "33626188268", owner: "160449865@N05", secret: "0a5c90af6a", server: "7890", farm: "8", title: "Dexter by the Platte River", ispublic: "1", isfriend: "0", isfamily: "", keyword: "1")
        let expect = self.expectation(description: "imageFetch")
        
        // Act
        imgSearchResult.fetchPhoto(url: imgSearchResult.photoUrl!) { (photoData) in
            imgSearchResult.photoImage = UIImage(data: photoData)
            expect.fulfill()
        }
        
        // Assert
        //wait(for: [expect], timeout: 7.0)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssert(imgSearchResult.photoImage != nil) // fails due to handler and expectation fulfillment, but image is pulled
    }
    
}
