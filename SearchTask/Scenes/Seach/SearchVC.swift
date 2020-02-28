//
//  SearchVC.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import UIKit

class SearchVC : BaseVC<SearchView> {
    
    private var presenter : ProSearchPresetner?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        /**
        - important: init preseter and implement protocol "ProSearchView"
         - Attention: set delegate and dataSource for tableView and set delegate for searchbar
         */
        
        presenter = SearchPresenter(view : self )
        mainView.setDelegateAndDataSource(delegate: self , dataSource: self )
        mainView.searchBar.delegate = self
        refreshController = mainView.tableViewSearch.addRefreshController()
        refreshController?.addTarget(self , action: #selector(refreshData), for: .valueChanged )
        
        
        
    }
    
    /**
     - Attention: call this method when user swipe to refresh
     */
    
    @objc private func refreshData () {
        presenter?.refreshData()
    }
    
    
}

extension SearchVC : ProSearchView {
    // call this method from presenter when get data from API
    func getDataSuccessfully() {
        mainView.tableViewSearch.reloadData()
    }
    
}


extension SearchVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        /**
         - important: check if cell is last cell or not
            and if yes --> call pagiation to load more data
         */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if tableView.visibleCells.contains(cell) {
                self?.presenter?.callPagination(index: indexPath.row)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCountData() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellTableViewRecipe.getIdentifier() , for: indexPath) as! CellTableViewRecipe
        presenter?.configurationCell(cell: cell , index: indexPath.row )
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(SingleRecipeVC(recipe : presenter?.getSingleRecipe(index : indexPath.row)) , animated : true )
    }
    
    
}

extension SearchVC : UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            presenter?.loadRecentData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.getMySearchData(searchText: searchBar.text ?? "" )
        self.mainView.endEditing(true)
    }
    
}
