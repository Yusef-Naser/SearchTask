//
//  SearchPresenter.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//VC

import Foundation

protocol ProSearchView : StatusApi {
    func getDataSuccessfully ()
    
}

protocol ProSearchPresetner {
    var searchText : String {get set}
    func getMySearchData(searchText : String)
    func getCountData() -> Int
    func refreshData()
    func callPagination(index: Int)
    func configurationCell (cell : ConfigurationCellRecipe , index : Int )
    func getSingleRecipe(index: Int) -> ModelRecipe?
    func loadRecentData ()
}


class SearchPresenter : ProSearchPresetner {
    
    weak var view : ProSearchView?
    private let interactor = SearchInteractor()
    private var paginateData = PaginationClass<ModelProduct> ()
    private var refresh = false
    
    internal var searchText = ""
    
    init(view : ProSearchView ) {
        self.view = view
    }
    
    func getSingleRecipe(index: Int) -> ModelRecipe? {
        if paginateData.listData.count > index {
            return paginateData.listData[index].recipe
        }
        return nil
    }
    
    func getMySearchData(searchText : String) {
        self.searchText = searchText
        if  !( paginateData.beforeCallService() ) {
            return
        }
        if refresh {
            refresh = false
        }else {
            self.view?.showLoading()
        }
        
        interactor.callSearchApi(query: searchText , from: paginateData.from , to: paginateData.to ) { [weak self] (result) in
            DispatchQueue.main.async { [weak self] in
                self?.view?.hideLoading()
                self?.paginateData.paginate = false 
                switch result {
                case .error(let data , _ ) :
                    self?.view?.onError(data.message ?? "" )
                    return
                case .success(let data , _) :
                    if data.hits?.count ?? 0 > 0 {
                        SharedData.instance.setRecent(list: data.hits ?? [] )
                    }
                    self?.paginateData.setDataPagination(listData: data.hits ?? [] , more: data.more ?? false )
                    self?.view?.getDataSuccessfully()
                    return
                case .failure(let error , _ ) :
                    self?.view?.onError( error.localizedDescription )
                    return
                case .none:
                    return
                }
            }
            
        }
        
    }
    
    func getCountData() -> Int {
        return paginateData.listData.count
    }
    
    func refreshData() {
        refresh = true
        paginateData.resetData()
        getMySearchData(searchText: searchText )
    }
    
    func callPagination(index: Int) {
        if paginateData.allowPagination(index: index) {
            getMySearchData(searchText: searchText)
        }
    }
    
    func configurationCell(cell: ConfigurationCellRecipe, index: Int) {
        if index >= paginateData.listData.count {
            return
        }
        let data = paginateData.listData[index]
        cell.imageRecipe(url: data.recipe?.image ?? "" )
        cell.setSource(source: data.recipe?.source ?? "" )
        cell.setTitle(title: data.recipe?.label ?? "" )
        cell.setHealthLabel(health: data.recipe?.healthLabels ?? [])
    }
    
    
    func loadRecentData () {
        paginateData.listData = SharedData.instance.getRecent()
        self.view?.getDataSuccessfully()
    }
    
}
