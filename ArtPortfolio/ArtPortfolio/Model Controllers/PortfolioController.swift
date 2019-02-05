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
    private let baseURL = URL(string: "https://backend-art.herokuapp.com/api/register")!
    
    func registerUser(username: String, fullname: String, password: String, email: String?, userProfileImage: String?, completion: @escaping(Error?) -> Void){
        
  //      let users = Users(username: username, fullname: fullname, userImage: nil, email: nil, password: password)
        
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
        
        request.httpMethod = "POST"
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
        
        request.httpMethod = "POST"
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
                
                print(users)
                
                completion(nil)
            } catch {
                print("Error decoding: \(error)")
                completion(error)
            }
 
            }.resume()
    }
 
    
}
