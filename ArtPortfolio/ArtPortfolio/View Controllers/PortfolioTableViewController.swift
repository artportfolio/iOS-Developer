//
//  PortfolioTableViewController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class PortfolioTableViewController: UITableViewController {

    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var cellTappedIndex = 0

    
    var portfolioController = PortfolioController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
        let userDefults = UserDefaults.standard
        
        if userDefults.string(forKey: "token") != nil {
            addBarButton.isEnabled = true
        } else {
        
            addBarButton.isEnabled = false
        }
        
        fetchPosts()
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        fetchPosts()
//    }


    func fetchPosts() {
      
        portfolioController.removeAll()
        
        ProgressHUD.show("Fetching Data...", interaction: true)
        portfolioController.fetchPosts { (posts, error) in
            if let error = error {
                print("Error loading posts in Table VC: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                ProgressHUD.showSuccess()
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return portfolioController.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioTableViewCell

        cell.selectionStyle = .none
        let portfolio = portfolioController.posts[indexPath.row]

       
        cell.delegate = self
        cell.thumbsupDelegate = self
       
        cell.portfolio = portfolio
        cell.portfolioController = portfolioController
cell.updateViews()

        return cell
        
    }

    
   //  MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? DetailViewController
            destinationVC?.portfolioController = portfolioController
            
         
            let portfolio = portfolioController.posts[cellTappedIndex]
            
            destinationVC?.portfolio = portfolio
        
        }
    }
  
   
    @IBAction func cancelBarButtonAction(_ sender: UIBarButtonItem) {
       // dismiss(animated: true)
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeNavBar") as UIViewController
  
        self.present(viewController, animated: true, completion: nil)
    }
    
}

extension PortfolioTableViewController: PortfolioCellDelegate {
    func tappedReadMoreButton(on cell: PortfolioTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        cellTappedIndex = indexPath.row
        
        performSegue(withIdentifier: "toDetailVC", sender: self)
      
    }
    
    
}

extension PortfolioTableViewController: ThumbsupCellDelegate {
    
    
    func tappedThumbsUp(on cell: PortfolioTableViewCell) {
       
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let posts = portfolioController.posts[indexPath.row]
        var upvoteValue = posts.upvotes
        upvoteValue += 1
        portfolioController.updateUpvoteValue(of: posts)
        
        portfolioController.upVotePost(postId: posts.id, upvote: upvoteValue) { (error) in
            if let error = error {
                print("Error upvoting: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [indexPath], with: .none)
              
            }
        }
        
    }
    
}
