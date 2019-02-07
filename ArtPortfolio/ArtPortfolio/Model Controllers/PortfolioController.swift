//
//  PortfolioController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PortfolioController {
    
     var cache = Cache<Int, UIImage>()
    
    private(set) var users: [Users] = []
    private(set) var posts: [Posts] = []
    private(set) var postUpdate: [PostUpdate] = []
    private let baseURL = URL(string: "https://backend-art.herokuapp.com/api/register")!
    
    func removeAll() {
        posts.removeAll()
    }
    
    func registerUser(username: String, fullname: String, password: String, email: String?, userProfileImage: String?, completion: @escaping(Error?) -> Void){
        
//        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//        let usernameItem = URLQueryItem(name: "username", value: username)
//        let fullNameItem = URLQueryItem(name: "fullName", value: fullname)
//        let passwordItem = URLQueryItem(name: "password", value: password)
//
//
//        urlComponents?.queryItems = [usernameItem, fullNameItem, passwordItem]
     //   let newURL = baseURL.appendingPathComponent("?username=\(username)&fullName=\(fullname)&password=\(password)")
        let params = ["username": username, "fullName": fullname, "password": password]
      //  let body = "username=\(username)&fullName=\(fullname)&password=\(password)"
      //  guard let urlComponentsUW = urlComponents?.url else {return}
        
        guard let body = try? JSONEncoder().encode(params) else { return }
        var request = URLRequest(url: baseURL)
        
        request.httpMethod = HTTPHelper.post.rawValue
        request.httpBody = body
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error getting shared data task: \(error)")
                completion(error)
            }
            
            if let response = response {
                print("Response: \(response)")
                completion(nil)
            }
            
            completion(nil)

            
        }.resume()
        
    }
    
    
    func login(username: String, password: String, completion: @escaping(Error?) -> Void){
        
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/login")!
        
        let params = ["username": username, "password": password]
        
        guard let body = try? JSONEncoder().encode(params) else { return }
        var request = URLRequest(url: baseURL)
        
        request.httpMethod = HTTPHelper.post.rawValue
        request.httpBody = body
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR getting data: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                print("No data returned: \(error!)")
                completion(error)
                return
            }
 
            let decoder = JSONDecoder()
            
            do {
                let user = try decoder.decode(UserLogin.self, from: data)
                
                //Save the token
               let userDefaults =  UserDefaults.standard
                userDefaults.set(user.token, forKey: "token")
                //Save the userID
                userDefaults.set(user.id, forKey: "userId")

                print(user)
                
                completion(nil)
            } catch {
                print("Error decoding: \(error)")
                completion(error)
            }
 
            }.resume()
    }
 
    
    func fetchUserInfo(completion: @escaping(Users?, Error?) -> Void){
        
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/login")!
        
       let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR WITH DATA TASK: \(error)")
                completion(nil, error)
            }
            
            if let response = response {
                print("RESPONSE: \(response)")
            }
            
            guard let data = data else {
                print("No data returned: \(error!)")
                completion(nil, error)
                return
                
            }
            
            let decoder = JSONDecoder()
            
            do {
              let users = try decoder.decode(Users.self, from: data)
                self.users.append(users)
                print(users)
                completion(users, nil)
            } catch {
                print("ERROR DECODING: \(error)")
                completion(nil, error)
            }
            
        }.resume()

    }
    
    func fetchPosts(completion: @escaping([Posts]?, Error?) -> Void){
        
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/posts")!
        
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("ERROR WITH DATA TASK: \(error)")
                completion(nil, error)
            }
            
            if let response = response {
                print("RESPONSE: \(response)")
            }
            
            guard let data = data else {
                print("No data returned: \(error!)")
                completion(nil, error)
                return
                
            }
            
            let decoder = JSONDecoder()
            
            do {
                let posts = try decoder.decode([Posts].self, from: data)
                self.posts.append(contentsOf: posts)
                print("POSTS: \(posts)")
                completion(posts, nil)
            } catch {
                print("ERROR DECODING: \(error)")
                completion(nil, error)
            }
            
            }.resume()
        
        
        
    }
    
    func createPostsWith(postName: String, imageUrl: String?, description: String?, completion: @escaping(Error?) -> Void){
        
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/posts")!
        
        let params = ["postName" : postName, "imageUrl": imageUrl, "description" : description]
        
        guard let body = try? JSONEncoder().encode(params) else { return }
        var request = URLRequest(url: baseURL)
        
        let userDefaults = UserDefaults.standard
        
        let authToken = userDefaults.value(forKeyPath: "token") as? String
        
        request.httpMethod = HTTPHelper.post.rawValue
        request.httpBody = body
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error with the requst: \(error)")
                completion(error)
            }
            
            if let response = response {
                print("Response from request: \(response)")
                completion(nil)
            }
      
        }.resume()
    }
    
    
    func deletePost(postId: Int, completion: @escaping (Error?) -> Void){
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/posts/\(postId)")!
        
        var request = URLRequest(url: baseURL)
        
        let userDefaults = UserDefaults.standard
        
        let authToken = userDefaults.value(forKeyPath: "token") as? String
        
        request.httpMethod = HTTPHelper.delete.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error with request delete: \(error)")
                completion(error)
            }
            
            if let response = response {
                print("Delete response: \(response)")
                completion(nil)
            }
            
        }.resume()
    }
    
    func editPostWith(id: Int, postName: String?, imageUrl: String?, description: String?, completion: @escaping(Error?) -> Void){
        
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/posts/\(id)")!
        
        let newPost = PostUpdate(postName: postName, imageUrl: imageUrl, description: description)
        
        var request = URLRequest(url: baseURL)
        
        let userDefaults = UserDefaults.standard
        
        let authToken = userDefaults.value(forKeyPath: "token") as? String
        
        request.httpMethod = HTTPHelper.put.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "authorization")
        
        
        do {
            let jsonEncoder = JSONEncoder()
            let newUpdatedPost =  try jsonEncoder.encode(newPost)
            request.httpBody = newUpdatedPost
        } catch {
            NSLog("Error encoding new message thread \(newPost)")
            completion(error)
            return
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error with request delete: \(error)")
                completion(error)
            }
            
            if let response = response {
                print("Delete response: \(response)")
                completion(nil)
            }
            
            }.resume()
    }
    
    func upVotePost(postId: Int, upvote: Int, completion: @escaping(Error?) -> Void){
        let baseURL = URL(string: "https://backend-art.herokuapp.com/api/posts/upvote/\(postId)")!
        let upvote = Upvote(upvotes: upvote)
        
        var request = URLRequest(url: baseURL)
        
        let userDefaults = UserDefaults.standard
        
        let authToken = userDefaults.value(forKeyPath: "token") as? String
        
        request.httpMethod = HTTPHelper.put.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(authToken, forHTTPHeaderField: "authorization")
        
        
        do {
            let jsonEncoder = JSONEncoder()
            let newUpvote =  try jsonEncoder.encode(upvote)
            request.httpBody = newUpvote
        } catch {
            NSLog("Error encoding new message thread \(upvote)")
            completion(error)
            return
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error with request delete: \(error)")
                completion(error)
            }
            
            if let response = response {
                print("Delete response: \(response)")
                completion(nil)
            }
            
            }.resume()
    }
    
    func fetchImage(for post: Posts, completion: @escaping (UIImage?) -> Void) {
        
        if let image = cache.value(for: post.id) {
            completion(image)
        } else {
            
            guard let urlString = post.imageUrl,
                let url = URL(string: urlString) else { completion(nil); return }
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                
                if let error = error {
                    print("Error fetching image: \(error)")
                    completion(nil)
                }
                
                guard let data = data,
                    let image = UIImage(data: data) else { completion(nil); return }
                
                self.cache.cache(value: image, for: post.id)
                
                completion(image)
                }.resume()
        }
    }
   
}
