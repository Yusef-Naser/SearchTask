//
//  SingleRecipeVCTests.swift
//  SearchTaskTests
//
//  Created by yusef naser on 2/28/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import XCTest
@testable import SearchTask

class SingleRecipeVCTests: XCTestCase {

    var sut : SingleRecipeVC!
    
    private var recipeObject : ModelRecipe = {
        let m = ModelRecipe(uri: "uri model", label: "label model", image: "image model", source: "source model" , url: "url model" , shareAs: nil , yield: nil , dietLabels: nil, healthLabels: ["healthLabels1" , "healthLabels2" , "healthLabels3"] , cautions: nil, ingredientLines: ["ingredientLines1" , "ingredientLines2" , "ingredientLines3"], ingredients: nil, calories: nil, totalWeight: nil, totalTime: nil, totalNutrients: nil, totalDaily: nil, digest: nil)
        return m
    }()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SingleRecipeVC(recipe: recipeObject )
        UIApplication.shared.keyWindow!.rootViewController = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func test_setDataForViews () {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.mainView.labelTitle.text , "label model" )
        XCTAssertEqual(sut.mainView.labelIngredientLines.text , sut.textIngredientLines)
        XCTAssertEqual(sut.mainView.urlLabel.text , "url model" )
    }

}

