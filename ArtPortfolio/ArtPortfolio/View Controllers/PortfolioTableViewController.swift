//
//  PortfolioTableViewController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PortfolioTableViewController: UITableViewController {
    
    var portfolioController = PortfolioController()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
        
    }

    
    func fetchPosts() {
        portfolioController.loadPosts { (error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return portfolioController.artPortfolioUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioTableViewCell

     let portfolio = portfolioController.artPortfolioUsers[indexPath.row]
       
        cell.portfolio = portfolio

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
