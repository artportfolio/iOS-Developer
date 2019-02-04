//
//  User.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Users: Codable {
   
    var uid: Int
    var email: String
    var userName: String
    let posts: Post
    
    enum CodingKeys: String, CodingKey {
        case uid, email, posts
        case userName = "username"
    }
   
}

struct Post: Codable {
    let postId: Int
    let postDescription: String
    let imageUrl: String
    let date: String
    let likes: Int
    
    
    enum CodingKeys: String, CodingKey {
        case date
        case postId = "postid"
        case postDescription = "description"
        case imageUrl = "image_url"
        case likes = "Likes"
    }
}

//This is the real User Object; Above one is dummy one.
struct User: Equatable, Codable {
    var id: Int
    var userName: String
    var fullName: String
    var userImgUrl: String?
    var email: String?
}
