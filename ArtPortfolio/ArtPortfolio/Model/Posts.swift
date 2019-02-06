//
//  Post.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Posts: Equatable, Codable {
    var postName: String
    var imageUrl: String?
    var upvotes: Int
    var id: Int
    var userId: Int
    var description: String?
}
