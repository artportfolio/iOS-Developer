//
//  User.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Users: Equatable, Codable {
  //  var id: Int
    var userName: String
    var fullName: String
    var userImgUrl: String?
    var email: String?
    var password: String
    
        enum CodingKeys: String, CodingKey {
            case userImgUrl, email
            case userName = "username"
            case fullName = "fullName"
            case password = "password"
        }
    
    init(username: String, fullname: String, userImage: String?, email: String?, password: String){
       self.userName = username
        self.fullName = fullname
        self.userImgUrl = userImage
        self.email = email
        self.password = password
    }
}


