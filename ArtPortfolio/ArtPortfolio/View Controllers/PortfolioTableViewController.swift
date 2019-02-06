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
    
//    let spinner = UIActivityIndicatorView(style: .gray)
    


    override func viewDidLoad() {
        super.viewDidLoad()

        
 //       fetchPosts()
     //   tableView.backgroundView = spinner
        
        
        addBarButton.isEnabled = false
        
    }

//
//    func fetchPosts() {
//      //  spinner.startAnimating()
//        ProgressHUD.show("Fetching Data...", interaction: true)
//        portfolioController.loadPosts { (error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                ProgressHUD.showSuccess()
//              //  self.spinner.stopAnimating()
//            }
//
//        }
//    }
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return portfolioController.artPortfolioUsers.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioTableViewCell
//
//     let portfolio = portfolioController.artPortfolioUsers[indexPath.row]
//
//        cell.delegate = self
//        cell.portfolio = portfolio
//
//
//        return cell
//    }

    
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetailVC" {
//            let destinationVC = segue.destination as? DetailViewController
//            destinationVC?.portfolioController = portfolioController
//            
//         
//            let portfolio = portfolioController.artPortfolioUsers[cellTappedIndex]
//            
//            destinationVC?.portfolio = portfolio
//        }
//    }
  
   
    @IBAction func cancelBarButtonAction(_ sender: UIBarButtonItem) {
       // dismiss(animated: true)
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as UIViewController
  
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
