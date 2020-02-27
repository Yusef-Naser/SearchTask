//
//  ApiRouter.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/26/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import Foundation


public protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest
}

enum ApiRouter : URLRequestConvertible {
    
    case search(q : String , from : Int , to : Int )
    
    private var Methods : String {
        switch self {
        case .search:
            return "GET"
        }
    }
    
    private var Headers : [String : String] {
        switch self {
        case .search :
            return [
                "Accept-Encoding" : "gzip" ,
                "Content-Encoding" : "gzip"
            ]
        }
    }
    
    private var Paths : String {
        switch self {
        case .search( let q,let from ,let  to ):
            return "/search?q=\(q)&from=\(from)&to=\(to)"
        }
    }
    
    func asURLRequest() -> URLRequest {
        switch self {
        case .search :
            let url = "\(BASE_URL)\(Paths)&app_id=\(APP_ID)&app_key=\(APP_KEY)"
            let safeUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            var urlRequest = URLRequest(url: URL(string: safeUrl!)!)
            urlRequest.allHTTPHeaderFields = Headers
            return urlRequest
        }
    }
    
}
