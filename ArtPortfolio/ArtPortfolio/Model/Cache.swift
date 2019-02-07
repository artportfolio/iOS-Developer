//
//  Cashe.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/6/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    
    // Create a queue especially for Cache.
    // So it makes Cache thread-safe to be shared between two different threads
    
    private var cache = [Key : Value]()
    private let queue = DispatchQueue(label: "com.LambdaSchool.Astronomy.CacheQueue")
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func value(for key: Key) -> Value? {
        return queue.sync { cache[key] }
    }
    
    func clear() {
        queue.async {
            self.cache.removeAll()
        }
    }
    
   
}
