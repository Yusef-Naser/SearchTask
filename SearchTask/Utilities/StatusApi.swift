//
//  StatusApi.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

protocol StatusApi : class  {
    func showMessage (_ message : String )
    func onError(_ message : String  )
    func onFailure (_ message : String  )
    func showLoading ()
    func hideLoading ()
    
}
