//
//  SearchView.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//VC

import UIKit


class SearchView : UIView {
    
    let searchBar : UISearchBar = {
        let s = UISearchBar()
        
        return s
    }()
    
    let tableViewSearch : UITableView = {
       let t = UITableView()
        t.tableFooterView = UIView()
        t.register(CellTableViewRecipe.self , forCellReuseIdentifier: CellTableViewRecipe.getIdentifier() )
        t.keyboardDismissMode = .onDrag
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews () {
        addViews()
    }
    
    private func addViews () {
        self.addSubview(searchBar)
        self.addSubview(tableViewSearch)
        
        if #available(iOS 11.0, *) {
            searchBar.anchor(top: self.safeAreaLayoutGuide.topAnchor , leading: leadingAnchor , trailing: trailingAnchor )
        } else {
            searchBar.anchor(top: self.topAnchor , leading: leadingAnchor , trailing: trailingAnchor )
        }
        tableViewSearch.anchor(top: searchBar.bottomAnchor , leading: leadingAnchor , bottom: bottomAnchor , trailing: trailingAnchor )
        
    }
    
    func setDelegateAndDataSource (delegate : UITableViewDelegate , dataSource : UITableViewDataSource) {
        self.tableViewSearch.delegate = delegate
        self.tableViewSearch.dataSource = dataSource
    }
    
    
}
