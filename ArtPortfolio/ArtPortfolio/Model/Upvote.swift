//
//  Upvote.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/6/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Upvote: Codable {
    var upvotes: Int
    
    init(upvotes: Int){
        self.upvotes = upvotes
    }
}
