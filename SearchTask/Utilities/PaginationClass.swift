//
//  PaginationClass.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import Foundation



/**
 
 Example :
 
 let pagination = PaginationClass<String>()
 
 
    func callPagination (index : Int ) {
        if pagination.allowPagination(index: index) {
            callGetData()
        }
    }
 
    // when user wip to refresh
     func refreshData() {
         pagination.resetData()
         callGetData()
     }
 
 
    // get item in list
    func getItemInList ( index : Int  ) {
        let item =   pagination.listData[index]
    }
 
    func getData () {
            if  !( pagination.beforeCallService() ) {
                return
            }
            // call get data   ( page :  pagination.currentPage   )
            // get get data is success
            self.pagination.setDataPagination(listData : responseList  ,
                currentPage: data?.meta.currentPage ?? 1  ,
                lastPage: data?.meta.lastPage ?? 1  )
    }
 
 
 
 */


class PaginationClass <T> {
    
    var from : Int = -1
    var to : Int = 0
    var count = 0
    var more : Bool = true
    var paginate : Bool = false
    var listData : [T] = []
    private var firstLoad = true
    
    
    func resetData() {
        listData = []
        from = 0
        to = 10
        paginate = false

        
    }
    
    
    func beforeCallService () -> Bool  {
        if from >= to {
            return false
        }
        if paginate {
            return false
        }
        paginate = true
        
        firstLoad = false
        
        from = to
        if to + 10 >= count && count != 0  {
            to = count
        }else {
            to += 10
        }

        
        return true
    }
    
    func isFirstLoad () -> Bool {
        
        return firstLoad
    }
    
    func setDataPagination (listData : [T] , more : Bool  ) {
        self.more = more
        self.paginate = false
        self.listData += listData
        firstLoad = false
        
    }
    
    
    func allowPagination (index : Int ) -> Bool {
        
        if paginate {
            return false
        }

        if index == listData.count - 1 {
            return true
        }
        
        if !more {
            return false
        }
        
                
        return false
    }
    
    
}
