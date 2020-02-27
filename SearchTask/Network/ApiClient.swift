//
//  ApiClient.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/25/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import Foundation

typealias CompletionHandler <T : Codable> = ( T? , Error? , _ statusCode : Int ) -> ()

class ApiClient <T : Decodable > {
    
    
    static func performRequest (route:ApiRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping ( T? , Error? , _ statusCode : Int )->Void) {
        
        let session = URLSession.shared
        let request = route.asURLRequest()
        let task = session.dataTask(with: request) { (data , response , error) in
            var statusCode = -1
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            // if statusCode == 429
            //status: "error",
            //message: "Usage limits are exceeded"
            
            if let data = data {
                do{
                    let responseModel = try decoder.decode(T.self, from: data)
                    completion( responseModel , nil , statusCode )
                }catch{
                    completion( nil , error , statusCode )
                }
            }else {
                completion( nil , error , statusCode )
            }
            
            
        }
        task.resume()
    }
    
//    @discardableResult
//    static func performRequest(route:ApiRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError> , _ statusCode : Int )->Void) -> DataRequest {
//        return AF.request(route)
//                .responseDecodable(decoder:decoder) {(response: DataResponse<  T , AFError >) in
//                    print(response.result)
//                    completion(response.result , response.response?.statusCode ?? -1 )
//        }
//    }
    
}
