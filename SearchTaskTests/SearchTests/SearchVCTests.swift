//
//  SearchVCTests.swift
//  SearchTaskTests
//
//  Created by yusef naser on 2/28/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import XCTest
@testable import SearchTask

class SearchVCTests: XCTestCase {

    var sut : SearchVC!
    let presenter = SearchPresenterMock ()
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchVC()
        UIApplication.shared.keyWindow!.rootViewController = sut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func test_delegateAndDataSourceTableView () {
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.mainView.tableViewSearch.delegate is SearchVC )
        XCTAssertTrue(sut.mainView.tableViewSearch.dataSource is SearchVC )
    }
    
    func test_refreshControllerNotNil () {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.refreshController)
    }
    
    func test_setDelegateAndDataSource () {
        let t = MockTableView (frame: CGRect(x: 0 , y: 0,  width: 200 , height: 200) )
        t.delegate = self
        t.dataSource = self
        t.register(CellSearchMock.self , forCellReuseIdentifier: CellSearchMock.getIdentifier() )
        sut.mainView.addSubview(t)
        t.reloadData()
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 5))
        
        let rows = t.numberOfRows(inSection: 0)
        
        XCTAssertEqual(rows , 6 )
        
        let cell = t.cellForRow(at: IndexPath(row: 0, section: 0 ))

        if let cell = cell as? CellSearchMock {
            
           XCTAssertTrue(cell.callHealth > 0 )
            XCTAssertTrue(t.callDequeuedCell > 0 )
            XCTAssertTrue(presenter.callConfigrationCell > 0)
            
        }else {
            XCTFail()
        }
        
    }
    
    
    func test_setDelegateInSUTIsSelf () {
           
           let table = sut.mainView.tableViewSearch
           
           sut.loadViewIfNeeded()
           table.delegate = self
           table.dataSource = self
           
           table.reloadData()
           
           let rows = table.numberOfRows(inSection: 0)
           
           XCTAssertEqual(rows , 6 )
           
           let cell = table.cellForRow(at: IndexPath(row: 0, section: 0 ))
           
           XCTAssertNotNil(cell as? CellTableViewRecipe )
           
           
       }
    
 
}


extension SearchVCTests : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView is MockTableView {
                   
            let cell = tableView.dequeueReusableCell(withIdentifier: CellSearchMock.getIdentifier() , for: indexPath) as! CellSearchMock
            presenter.configurationCell(cell: cell , index: indexPath.row)
            
            
            return cell
                   
        }else {
                   
            let cell = tableView.dequeueReusableCell(withIdentifier: CellTableViewRecipe.getIdentifier() , for: indexPath) as! CellTableViewRecipe
            presenter.configurationCell(cell: cell , index: indexPath.row)
            return cell
                   
        }
        
    }
    
    
}


extension SearchVCTests  {
    
    class MockTableView : UITableView {
        var callDequeuedCell = 0
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            callDequeuedCell += 1
            return super.dequeueReusableCell(withIdentifier: identifier , for: indexPath)
        }
    }
    
    class SearchPresenterMock : ProSearchPresetner {
        var searchText: String = ""
        
        var callConfigrationCell = 0
        
        private var pagination : PaginationClass<Int> {
            let p = PaginationClass<Int>()
            p.listData = [2 ,3 , 55 , 1 , 904 , 76 ]
            return p
        }
        
        
        func getMySearchData(searchText: String) {
            
        }
        
        func getCountData() -> Int {
            return pagination.listData.count
        }
        
        func refreshData() {
            
        }
        
        func callPagination(index: Int) {
            
        }
        
        func configurationCell(cell: ConfigurationCellRecipe, index: Int) {
            callConfigrationCell += 1
            cell.imageRecipe(url: "url image")
            cell.setHealthLabel(health: ["HealthLabel1" , "HealthLabel2" , "HealthLabel3"])
            cell.setSource(source: "source recipe")
            cell.setTitle(title: "title recipe")
        }
        
        func getSingleRecipe(index: Int) -> ModelRecipe? {
            return nil
        }
        
        func loadRecentData() {
            
        }
        
        
    }
    
    class CellSearchMock : UITableViewCell , ConfigurationCellRecipe {
        
        var callImage = 0
        var callTitle = 0
        var callSource = 0
        var callHealth = 0
        
        func imageRecipe(url: String) {
            callImage += 1
            XCTAssertEqual(url , "url image" )
        }
        
        func setTitle(title: String) {
            callTitle += 1
            XCTAssertEqual(title , "title recipe" )
        }
        
        func setSource(source: String) {
            callSource += 1
            XCTAssertEqual(source  , "source recipe" )
        }
        
        func setHealthLabel(health: [String]) {
            callHealth += 1
            XCTAssertEqual(health , ["HealthLabel1" , "HealthLabel2" , "HealthLabel3"] )
        }
        
        
    }
    
    
}
