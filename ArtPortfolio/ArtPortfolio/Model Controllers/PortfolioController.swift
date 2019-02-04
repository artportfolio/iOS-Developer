//
//  PortfolioController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class PortfolioController {
    
    private(set) var artPortfolioUsers: [Users] = []
    
    private let baseURL = URL(string: "https://my.api.mockaroo.com/artportfolio.json?key=679599f0")!
    
    
//    func loadPortfolioPosts(completion: @escaping (Portfolio?, Error?) -> Void) {
//
//
//        let request = URLRequest(url: baseURL)
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            if error != nil {
//                NSLog("Error fetching data: \(error!)")
//                completion(nil, error)
//                return
//            }
//            guard let data = data else {
//                NSLog("No data returned")
//                completion(nil, error)
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            do {
//                let portfolio = try decoder.decode(Portfolio.self, from: data)
//
//                completion(portfolio, nil)
//            } catch {
//                NSLog("Error decoding data: \(error)")
//                completion(nil, error)
//                return
//            }
//            }.resume()
//
//    }
    
    func loadPosts(completion: @escaping (Error?) -> Void) {
        
        
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error != nil {
                NSLog("Error fetching data: \(error!)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let portfolio = try decoder.decode([Users].self, from: data)
                self.artPortfolioUsers.append(contentsOf: portfolio)
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            }.resume()
        
    }
    
    
    
}
