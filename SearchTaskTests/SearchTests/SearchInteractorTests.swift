//
//  SearchInteractorTests.swift
//  SearchTaskTests
//
//  Created by yusef naser on 2/28/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import XCTest
@testable import SearchTask

class SearchInteractorTests: XCTestCase {

    var sut : SearchInteractor!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    
    func test_getSearch() {
         let e = expectation(description: "search")
        sut.callSearchApi(query: "chicken", from: 0 , to: 10) { (result) in
            e.fulfill()
            
            switch result {
            case .success(let data , let statusCode) :
                XCTAssertEqual(statusCode , 200 )
                XCTAssertNil(data.status)
                break
            case .failure(let error , let statusCode) :
                break
            case .error(let data , let statusCode) :
                if statusCode == 429 {
                    XCTFail("limmit")
                }
                break
            case .none : return
            }
            
        }
        waitForExpectations(timeout: 5 , handler: nil )
    }
    

   
}
