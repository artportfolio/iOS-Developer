//
//  PostUpdate.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/6/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

import Foundation

struct PostUpdate: Equatable, Codable {
    var postName: String?
    var imageUrl: String?
    var description: String?
    
    init(postName: String?, imageUrl: String?, description: String?){
        self.postName = postName
        self.imageUrl = imageUrl
        self.description = description
        
    }
}
