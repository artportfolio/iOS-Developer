//
//  PortfolioController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class PortfolioController {
    
    private(set) var users: [Users] = []
    private(set) var posts: [Posts] = []
    private let baseURL = URL(string: "https://backend-art.herokuapp.com/api/register")!
    
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
                let users = try decoder.decode(UserLogin.self, from: data)
                
                //Save the token
               let userDefaults =  UserDefaults.standard
                userDefaults.set(users.token, forKey: "token")
                //Save the userID
                userDefaults.set(users.id, forKey: "userId")

                print(users)
                
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
                print(posts)
                completion(posts, nil)
            } catch {
                print("ERROR DECODING: \(error)")
                completion(nil, error)
            }
            
            }.resume()
        
        
        
    }
    
}
