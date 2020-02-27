//
//  SearchInteractor.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//VC

enum ResultApi<T:Decodable> {

    case success(T, Int)
    case error(T , Int )
    case failure(Error , Int )
    case none
}

typealias ResultHandler <T : Codable> = ( ResultApi<T> ) -> ()

class SearchInteractor {
    
    func callSearchApi (query : String , from : Int , to : Int , completion : @escaping ResultHandler<ModelSearch> ) {
        
        ApiClient<ModelSearch>.performRequest(route: .search(q: query , from: from , to: to )) { (data , error , statusCode) in
            
            if let data = data , statusCode == 429 {
                completion(.error(data , statusCode))
            }else if let data = data {
                completion(.success(data , statusCode))
            }else if let error = error {
                completion(.failure(error , statusCode))
            }else {
                completion(.none)
            }
            
        }
        
    }
    
    
}
