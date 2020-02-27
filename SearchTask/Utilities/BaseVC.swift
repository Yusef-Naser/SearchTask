//
//  BaseVC.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import UIKit

class BaseVC <T : UIView > : UIViewController , StatusApi {
    
    func showMessage(_ message: String) {
        createAlert(text: message)
    }
    
    func onError(_ message: String) {
         createAlert(text: message)
    }
    
    func onFailure(_ message: String) {
         createAlert(text: message)
    }
    
    func showLoading() {
        indicator.startAnimating()
    }
    
    func hideLoading() {
        refreshController?.endRefreshing()
        indicator.stopAnimating()
    }
    
    var refreshController : UIRefreshControl?
    lazy var indicator : UIActivityIndicatorView = {
       let i = UIActivityIndicatorView ()
        i.hidesWhenStopped = true
        mainView.addSubview(i)
        i.anchor( centerX: mainView.centerXAnchor , centerY: mainView.centerYAnchor )
        return i
    }()

    override func loadView() {
           let t  = T()
           t.backgroundColor = .white
           self.view = t
    }
       
    var mainView : T {
        if let view = self.view as? T {
            return view
        }else {
            let view = T()
            self.view = view
            return view
        }
    }
    
}

