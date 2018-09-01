//
//  MyDogTests.swift
//  MyDogTests
//
//  Created by Shreya Dutta Chowdhury on 01/09/18.
//  Copyright © 2018 Shreya Dutta Chowdhury. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import MyDog

class MyDogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPI()
    {
        let stubbedJSON = [
            "status": "success",
            "message": "https://images.dog.ceo/breeds/bulldog-boston/n02096585_1449.jpg"
            ]
        stub(condition: isHost("dog.ceo")) { (request) -> OHHTTPStubsResponse in
            
            return OHHTTPStubsResponse(jsonObject: stubbedJSON, statusCode: 200, headers: .none)
        }
        
        let expectation = self.expectation(description: "calls the callback with a resource object")
        
        let networkManager = NetworkManager.shared
        networkManager.fetchRandomDogImage(fromBreed: "bulldog") { (dog, error) in
            XCTAssertNil(error)
            XCTAssertEqual(dog?.status, stubbedJSON["status"])
            XCTAssertEqual(dog?.breedName, "bulldog")
            XCTAssertTrue((dog?.imageURL != nil))
           
            expectation.fulfill()
        }
        
        
        
        self.waitForExpectations(timeout: 5.0, handler: .none)
        
        // Tear Down
        //
        OHHTTPStubs.removeAllStubs()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
