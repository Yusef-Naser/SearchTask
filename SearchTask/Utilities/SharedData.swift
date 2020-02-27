//
//  SharedData.swift
//  SearchTask
//
//  Created by Yusef Naser on 2/27/20.
//  Copyright © 2020 Yusef Naser. All rights reserved.
//

import Foundation

class SharedData {

    static var instance = SharedData()
    private var userDefaults = UserDefaults.standard

    
    private let recentKey = "recentKey"

    
    private init(){
        
    }
    
    func setRecent (list : [ModelProduct]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(list) {
            userDefaults.set(encoded, forKey: recentKey )
        }
    }

    func getRecent () -> [ModelProduct] {
        if let savedPerson = userDefaults.object(forKey: recentKey ) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode([ModelProduct].self, from: savedPerson) {
               return loadedPerson
            }
        }
        return []
    }
    
}
