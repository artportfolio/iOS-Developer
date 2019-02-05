//
//  UserLogin.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
struct UserLogin: Codable {
    
    var id: Int
    var userName: String
    var fullName: String
    var userImgUrl: String?
    var email: String?
    var token: String
    
    
    enum CodingKeys: String, CodingKey {
        case userImgUrl, email, id, token
        case userName = "username"
        case fullName = "fullName"
    }
    
    
}
