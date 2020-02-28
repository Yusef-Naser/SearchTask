//
//  SingleRecipeViewTests.swift
//  SearchTaskTests
//
//  Created by yusef naser on 2/28/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import XCTest
@testable import SearchTask

class SingleRecipeViewTests: XCTestCase {

    var sut : SingleRecipeView!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SingleRecipeView()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    
    func test_LabelTitle () {
        let l = sut.labelTitle
        XCTAssertEqual(l.font , UIFont.systemFont(ofSize: 30 ))
        XCTAssertEqual(l.textAlignment , .center )
        XCTAssertEqual(l.numberOfLines , 0 )
        XCTAssertEqual(l.lineBreakMode , .byWordWrapping )
    }
    
    func test_labelIngredient () {
        let l = sut.labelIngredient
        XCTAssertEqual(l.text , "Ingredient Lines" )
        XCTAssertEqual(l.font , UIFont.systemFont(ofSize: 25 ) )
    }
    
    func test_labelIngredientLines () {
        let l = sut.labelIngredientLines
        XCTAssertEqual(l.numberOfLines , 0 )
        XCTAssertEqual(l.lineBreakMode , .byWordWrapping )
    }
    
    func test_urlLabel () {
        let l = sut.urlLabel
        XCTAssertEqual(l.numberOfLines , 0 )
        XCTAssertEqual(l.lineBreakMode , .byWordWrapping )
        XCTAssertEqual(l.textColor , .blue )
    }

}
