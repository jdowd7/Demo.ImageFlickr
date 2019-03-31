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
    
    var testControl_ImgSearchResult : ImageSearchResult?
    var testControl_ImgSearchResultUrl : URL?
    
    override func setUp() {
        super.setUp()
        self.testControl_ImgSearchResult = ImageSearchResult(id: "1", owner: "1", secret: "1", server: "1", farm: "1", title: "1", ispublic: "1", isfriend: "1", isfamily: "1", keyword: "1")
        self.testControl_ImgSearchResultUrl = URL(string: "https://farm1.staticflickr.com/1/1_1.jpg")
    }
    
    override func tearDown() {
        self.testControl_ImgSearchResultUrl = nil
        super.tearDown()
    }
    
    func testImageSearchResult_ContructorValid_ShouldEqualCorrectType() {
        // Arrange & Act
        let imgSearchResult = ImageSearchResult(id: "1", owner: "1", secret: "1", server: "1", farm: "1", title: "1", ispublic: "1", isfriend: "1", isfamily: "1", keyword: "1")
        // Assert
        XCTAssert(imgSearchResult.url == testControl_ImgSearchResultUrl)
    }
    
}
